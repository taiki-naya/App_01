require 'rails_helper'
RSpec.describe Item, type: :model do
  before do
    @store = FactoryBot.create(:store)
  end
  it 'name, size, price, store_id　が入力されていれば有効であること' do
    item = Item.new(
      name: 'item1',
      size: 'XL',
      price: 10000,
      store_id: @store.id
    )
    expect(item).to be_valid
  end
  it 'nameが空白であれば無効であること' do
    item = Item.new(
      name: '',
      size: 'XL',
      price: 10000,
      store_id: @store.id
    )
    expect(item).to be_invalid
  end
  it 'priceが空白であれば無効であること' do
    item = Item.new(
      name: 'item1',
      size: 'XL',
      price: nil,
      store_id: @store.id
    )
    expect(item).to be_invalid
  end
  it 'store_idが空白であれば無効であること' do
    item = Item.new(
      name: 'item1',
      size: 'XL',
      price: 10000,
      store_id: nil
    )
    expect(item).to be_invalid
  end
end
