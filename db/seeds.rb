# -----ストア＆商品-----

# store1 = Store.create!(name: 'スポーツショップA', link: 'sports_shop_a.com', address: '東京都千代田区千代田1-1')
# store2 = Store.create!(name: 'スポーツショップB', link: 'sports_shop_b.com', note: 'オンラインのみ')
# store3 = Store.create!(name: 'スポーツショップC', link: 'sports_shop_c.com', address: '東京都千代田区永田町1-7-1')
#
# 5.times do |n|
#     store1 = Store.find_by(name: 'スポーツショップA')
#     store2 = Store.find_by(name: 'スポーツショップB')
#     store3 = Store.find_by(name: 'スポーツショップC')
#
#     number = rand(0..5)
#     label_num = rand(6..20)
#     store_arr = [store1, store2, store3, store1, store2, store3]
#     size_arr  = ['Kids', 'XS', 'S', 'M', 'L', 'XL']
#
#     team = Faker::Sports::Football.team
#     item = Item.create!(
#                         name: "21-22 #{team}",
#                         size: size_arr[number],
#                         price: 10000,
#                         store_id: store_arr[number].id,
#                         )
#     LabellingOfItem.create!(
#         item_id: item.id,
#         labelable_type: 'Team',
#         labelable_id: label_num,
#     )
# end

# ---------Production用------------

#        -----Kit追加-----
# team_ids = League.find_by(name: '').teams.pluck(:id)
team_ids = Team.pluck(:id)
team_ids.each do |id|
  Kit.create!(series: '21-22 Home', team_id: id)
  Kit.create!(series: '21-22 Away', team_id: id)
  Kit.create!(series: '21-22 Third', team_id: id)
end
