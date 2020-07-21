# == Schema Information
#
# Table name: options
#
#  id         :bigint           not null, primary key
#  title      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  post_id    :integer
#  user_id    :integer
#
# Indexes
#
#  index_options_on_post_id  (post_id)
#  index_options_on_user_id  (user_id)
#
class Option < ApplicationRecord
  belongs_to :post
  belongs_to :user
  has_many :vote, dependent: :destroy
  validates :title, presence: true, length: { maximum: 30 }

  def vote_count
    Vote.where({ option_id: id }).count
  end
end
