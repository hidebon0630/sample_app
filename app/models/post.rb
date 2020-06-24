# == Schema Information
#
# Table name: posts
#
#  id         :bigint           not null, primary key
#  content    :text(65535)
#  image      :string(255)
#  title      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint
#
# Indexes
#
#  index_posts_on_user_id                 (user_id)
#  index_posts_on_user_id_and_created_at  (user_id,created_at)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Post < ApplicationRecord
  belongs_to :owner, class_name: 'User', foreign_key: :user_id
  default_scope -> { order(created_at: :desc) }
  mount_uploader :image, ImageUploader
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 100 }
  validates :title, presence: true, length: { maximum: 15 }
  validate :image_size
  has_many :likes
  has_many :liked_users, through: :likes, source: :user
  has_many :comments

  private

  def image_size
    errors.add(:image, 'should be less than 5MB') if image.size > 5.megabytes
  end
end
