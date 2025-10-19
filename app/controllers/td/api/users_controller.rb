class Td::Api::UsersController < ApplicationController
  def index
    users = User.where(school: current_user.school)
                .includes(posts: {comments: :user},
                          scores: {rubric: :lesson})
    hash = {} 
    users.each { |user|
      # handling posts related to the user
      p_ary = [] 
      user.posts.each { |post|
        c_ary = []
        post.comments.each { |comment|
          c_hash = comment.attributes
          c_hash[:user_name] = comment.user.name
          c_ary.push(c_hash)
        }
        post_h = post.attributes # this means 'post_h <- post.to_h'
        post_h[:user_name] = user.name
        post_h[:lesson_title] = post.lesson.title
        p_ary.push({ post_info: post_h, comments: c_ary })
      }
      # handling scores related to the user
      s_ary = []
      user.scores.each { |score|
        rubric = score.rubric
        lesson = rubric.lesson
        # FIXME: temporary patch
        next if user.school != lesson.school
        # the end of temporary patch
        s_hash = score.attributes
        s_hash[:rubric_item] = rubric.item
        s_hash[:lesson_id] = lesson.id
        s_hash[:lesson_title] = lesson.title
        s_ary.push(s_hash)
      }
      hash[user.id] = { user_info: user.attributes,
                        posts: p_ary, scores: s_ary }
    }
    render json: hash
  end
end
