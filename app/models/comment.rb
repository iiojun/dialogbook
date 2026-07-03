class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user

  after_create_commit -> {
    broadcast_append_to(
      post,
      target: ActionView::RecordIdentifier.dom_id(post, :comments),
      partial: "mypage/comments/comment",
      locals: { comment: self }
    )
  }
end
