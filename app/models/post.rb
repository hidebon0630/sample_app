class Post < ApplicationRecord
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  mount_uploader :image, imageUploader
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
end
