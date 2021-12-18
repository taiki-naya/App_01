require 'rails_helper'
RSpec.describe Kit, type: :model do
  before do
    @league = FactoryBot.create(:league)
    @team =FactoryBot.create(:team, league_id: @league.id)
  end
  it 'series, team_idが入力されていれば有効であること' do
    kit = Kit.new(
      series: '21-22 Home',
      team_id: @team.id
    )
    expect(kit).to be_valid
  end
  it 'nameが空白であれば無効であること' do
    kit = Kit.new(
      series: '',
      team_id: @team.id
    )
    expect(kit).to be_invalid
  end
  it 'team_idが空白であれば無効であること' do
    kit = Kit.new(
      series: '21-22 Home',
      team_id: nil
    )
    expect(kit).to be_invalid
  end
end
