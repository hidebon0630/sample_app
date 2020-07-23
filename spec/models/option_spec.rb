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
require 'rails_helper'

RSpec.describe Option, type: :model do
  describe 'バリデーション' do
    let!(:option) { create(:option) }
    it '項目ファクトリが有効' do
      option.valid?
      expect(option).to be_valid
    end

    it '項目内容が無い場合は無効' do
      option.title = nil
      option.valid?
      expect(option.errors[:title]).to include('を入力してください')
    end

    it '項目内容が30字以内の場合は有効' do
      option.title = 'a' * 30
      option.valid?
      expect(option).to be_valid
    end

    it '項目内容が31文字以上の場合は無効' do
      option.title = 'a' * 31
      option.valid?
      expect(option.errors[:title]).to include('は30文字以内で入力してください')
    end
  end

  describe '依存性' do
    it '項目を削除すると回答も削除される' do
      option = create(:option, :with_votes)
      expect { option.destroy }.to change { Vote.count }.by(-1)
    end
  end
end
