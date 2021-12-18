FactoryBot.define do
  factory :item do
    name { 'アイテム１' }
    size { 'XL' }
    price { 10000 }
    store_id { 1 }
  end
end
