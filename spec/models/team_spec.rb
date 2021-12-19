require 'rails_helper'
RSpec.describe Team, type: :model do
  before do
    @league = FactoryBot.create(:league, name: 'セリエA')
  end
  it 'name, home_town, established, description, league_id　が入力されていれば有効であること' do
    team = Team.new(
      name: 'トリノFC',
      home_town: 'ピエモンテ州トリノ',
      established: 1906,
      description: 'イタリア・トリノをホームタウンとするプロサッカークラブ。セリエAで優勝7回の実績を持つ古豪である。',
      league_id: @league.id
    )
    expect(team).to be_valid
  end
  it 'nameが空白であれば無効であること' do
    team = Team.new(
      name: '',
      home_town: 'ピエモンテ州トリノ',
      established: 1906,
      description: 'イタリア・トリノをホームタウンとするプロサッカークラブ。セリエAで優勝7回の実績を持つ古豪である。',
      league_id: @league.id
    )
    expect(team).to be_invalid
  end
  it 'establishedが空白であれば無効であること' do
    team = Team.new(
      name: 'トリノFC',
      home_town: 'ピエモンテ州トリノ',
      established: nil,
      description: 'イタリア・トリノをホームタウンとするプロサッカークラブ。セリエAで優勝7回の実績を持つ古豪である。',
      league_id: @league.id
    )
    expect(team).to be_invalid
  end
  it 'establishedが1850未満の数値であれば無効であること' do
    team = Team.new(
      name: 'トリノFC',
      home_town: 'ピエモンテ州トリノ',
      established: -5,
      description: 'イタリア・トリノをホームタウンとするプロサッカークラブ。セリエAで優勝7回の実績を持つ古豪である。',
      league_id: @league.id
    )
    expect(team).to be_invalid
  end
  it 'establishedが未来の年数であれば無効であること' do
    team = Team.new(
      name: 'トリノFC',
      home_town: 'ピエモンテ州トリノ',
      established: 3030,
      description: 'イタリア・トリノをホームタウンとするプロサッカークラブ。セリエAで優勝7回の実績を持つ古豪である。',
      league_id: @league.id
    )
    expect(team).to be_invalid
  end
end
