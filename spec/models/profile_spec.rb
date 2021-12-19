require 'rails_helper'
RSpec.describe Profile, type: :model do
  before do
    @user = FactoryBot.create(:user)
  end
  it 'name, jid, user_idが入力されていれば有効であること' do
    profile = Profile.new(
      name: 'テストユーザー',
      jid: 'modelspectestingnow',
      user_id: @user.id
    )
    expect(profile).to be_valid
  end
  it 'nameが空白であれば無効であること' do
    profile = Profile.new(
      name: '',
      jid: 'modelspectestingnow',
      user_id: @user.id
    )
    expect(profile).to be_invalid
  end
  it 'user_idが空白であれば無効であること' do
    profile = Profile.new(
      name: 'テストユーザー',
      jid: 'modelspectestingnow',
      user_id: nil
    )
    expect(profile).to be_invalid
  end
end
