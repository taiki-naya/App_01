require 'rails_helper'
RSpec.describe Store, type: :model do
  before do
    store1 = FactoryBot.create(:store, name: 'store1', link: 'https://store1')
  end
  it 'name, link, address, noteが入力されていれば有効であること' do
    store = Store.new(
      name: 'test-store',
      link: 'https://test-store',
      address: '42 Kingston Street, Auckland CBD, Auckland 1010 New Zealand',
      note: 'aka.Aotearoa'
    )
    expect(store).to be_valid
  end
  it 'nameが空白であれば無効であること' do
    store = Store.new(
      name: '',
      link: 'https://test-store',
      address: '42 Kingston Street, Auckland CBD, Auckland 1010 New Zealand',
      note: 'aka.Aotearoa'
    )
    expect(store).to be_invalid
  end
  it 'nameが既に登録してある名前であれば無効であること' do
    store = Store.new(
      name: 'store1',
      link: 'https://test-store',
      address: '42 Kingston Street, Auckland CBD, Auckland 1010 New Zealand',
      note: 'aka.Aotearoa'
    )
    expect(store).to be_invalid
  end
  it 'linkが空白であれば無効であること' do
    store = Store.new(
      name: 'test-store',
      link: '',
      address: '42 Kingston Street, Auckland CBD, Auckland 1010 New Zealand',
      note: 'aka.Aotearoa'
    )
    expect(store).to be_invalid
  end
  it 'linkが「https://~」で始まる文字列以外であれば無効であること' do
    store = Store.new(
      name: 'test-store',
      link: 'aaaaa',
      address: '42 Kingston Street, Auckland CBD, Auckland 1010 New Zealand',
      note: 'aka.Aotearoa'
    )
    expect(store).to be_invalid
  end
  it 'linkが「https://」の後ろに文字が続かなければ無効であること' do
    store = Store.new(
      name: 'test-store',
      link: 'https://',
      address: '42 Kingston Street, Auckland CBD, Auckland 1010 New Zealand',
      note: 'aka.Aotearoa'
    )
    expect(store).to be_invalid
  end
end
