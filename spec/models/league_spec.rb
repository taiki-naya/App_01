require 'rails_helper'
RSpec.describe League, type: :model do
  it 'name, nationalityが入力されていれば有効であること' do
    league = League.new(
      name: 'league1',
      nationality: 'Test'
    )
    expect(league).to be_valid
  end
  it 'nameが空白であれば無効であること' do
    league = League.new(
      name: '',
      nationality: 'Test'
    )
    expect(league).to be_invalid
  end
end
