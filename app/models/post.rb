# == Schema Information
#
# Table name: posts
#
#  id                :bigint           not null, primary key
#  image             :string(255)
#  impressions_count :integer          default(0)
#  status            :integer          default("published"), not null
#  title             :string(255)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  user_id           :integer
#
# Indexes
#
#  index_posts_on_user_id                 (user_id)
#  index_posts_on_user_id_and_created_at  (user_id,created_at)
#
class Post < ApplicationRecord
  mount_uploader :image, ImageUploader
  belongs_to :user
  belongs_to :owner, class_name: 'User', foreign_key: :user_id
  validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 30 }
  validate :image_size
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user
  has_many :comments, dependent: :destroy
  has_many :notifications, dependent: :destroy
  has_many :options, dependent: :destroy
  has_many :votes, dependent: :destroy
  enum status: { published: 0, draft: 1 }
  is_impressionable counter_cache: true

  def liked_by?(user)
    likes.exists?(user_id: user.id)
  end

  def create_notification_like!(current_user)
    temp = Notification.where(['visitor_id = ? and visited_id = ? and post_id = ? and action = ? ', current_user.id, user_id, id, 'like'])
    return unless temp.blank?

    notification = current_user.active_notifications.new(
      post_id: id,
      visited_id: user_id,
      action: 'like'
    )
    notification.checked = true if notification.visitor_id == notification.visited_id
    notification.save if notification.valid?
  end

  def create_notification_comment!(current_user, comment_id)
    temp_ids = Comment.select(:user_id).where(post_id: id).where.not(user_id: current_user.id).distinct
    temp_ids.each do |temp_id|
      save_notification_comment!(current_user, comment_id, temp_id['user_id'])
    end
  end

  def save_notification_comment!(current_user, comment_id, visited_id)
    notification = current_user.active_notifications.new(
      post_id: id,
      comment_id: comment_id,
      visited_id: visited_id,
      action: 'comment'
    )
    notification.checked = true if notification.visitor_id == notification.visited_id
    notification.save if notification.valid?
  end

  def create_notification_vote!(current_user, vote_id)
    notification = current_user.active_notifications.new(
      post_id: id,
      vote_id: vote_id,
      visited_id: user_id,
      action: 'vote'
    )
    notification.save if notification.valid?
  end

  private

  def image_size
    errors.add(:image, 'should be less than 5MB') if image.size > 5.megabytes
  end
end
