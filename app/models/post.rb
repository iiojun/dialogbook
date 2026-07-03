class Post < ApplicationRecord
  belongs_to :user
  belongs_to :lesson
  has_many :comments, -> { order(created_at: :asc) }, dependent: :destroy

  after_create_commit -> { sleep 0.2; broadcast_to_teachers }

  def record_response_from!(user)
    was_pending = need_response?
    update!(need_response: user.is_student?)

    if user.is_student? && was_pending
      broadcast_to_teachers
    end
  end

  def broadcast_to_teachers
    broadcast_prepend_to(
      "teacher_#{user.school.id}",
      target: "posts",
      partial: "mypage/posts/post",
      locals: { post: self }
    )

    Turbo::StreamsChannel.broadcast_remove_to(
      "teacher_#{user.school.id}",
      target: "empty-posts"
    )
  end
end
