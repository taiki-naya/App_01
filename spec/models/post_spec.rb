require 'rails_helper'
RSpec.describe Post, type: :model do
  before do
    @user = FactoryBot.create(:user)
  end
  it 'content, user_idが入力されていれば有効であること' do
    post = Post.new(
      content: 'test',
      user_id: @user.id
    )
    expect(post).to be_valid
  end
  it 'contentが空白であれば無効であること' do
    post = Post.new(
      content: '',
      user_id: @user.id
    )
    expect(post).to be_invalid
  end
  it 'user_idが空白であれば無効であること' do
    post = Post.new(
      content: 'test',
      user_id: nil
    )
    expect(post).to be_invalid
  end
end
