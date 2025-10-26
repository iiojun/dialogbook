class User < ApplicationRecord
  belongs_to :school, optional: true  # the school currently belongs to
  # candidate schools in which the user has permission to participate
  has_many :user_schools, dependent: :destroy
  has_many :schools, through: :user_schools

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :notes, dependent: :destroy
  has_many :scores, dependent: :destroy

  scope :with_role, ->(keyword) { where("role LIKE ?", "%#{keyword}%") }

  def self.find_or_create_from_auth(auth)
    provider = auth[:provider]
    uid = auth[:uid]

    self.find_or_create_by(provider: provider, uid: uid) do |user|
      user.email = auth[:info][:email]
      user.role = "student" if user.role == nil
    end
  end

  def self.admins
    User.with_role("admin")
  end

  def is_admin?
    has_keyword?("admin")
  end

  def is_student?
    has_keyword?("student")
  end

  def is_teacher?
    has_keyword?("teacher")
  end

  def prepare_scores
    # nothing to do if user is a teacher
    # or the student who does not belong to a school
    return nil if is_teacher? or school == nil

    if school.lessons.length > 0
      # get a set of rubrics which belong to the user's school
      rubrics = Rubric.joins(:lesson).where(lesson: { school: school })
                      .order("created_at asc")
      # if user's scores has already been prepared, return scores
      return scores if rubrics.length == scores.length

      # add new scores to fill in the self-evalations
      rubrics.each { |r|
        next if Score.find_by(rubric: r, user: self) != nil
        scores << Score.create(rubric: r, user: self)
      }
    end
    scores
  end

  def prepare_posts
    # nothing to do if user is a teacher
    # or the student who does not belong to a school
    return nil if is_teacher? or school == nil

    if school.lessons.length > 0
      # get a set of posts which belong to the user's school
      posts = Post.joins(:lesson)
                  .where(lesson: { school: school }, user: self)
                  .order("created_at asc")
      # if user's posts has already been prepared, return posts
      return self.posts if school.lessons.length == posts.length

      # add new posts to fill in the comments for lessons
      school.lessons.each { |l|
        next if Post.find_by(lesson: l, user: self) != nil
        self.posts << Post.create(lesson: l, user: self, body: "",
                                  need_response: false)
      }
    end
    posts
  end

  private

  def has_keyword?(key)
    role.split(",").include?(key)
  end
end
