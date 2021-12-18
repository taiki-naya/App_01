FactoryBot.define do
  factory :profile do
      name { 'テストロボット君' }
      introduction { 'ロボットで～す' }
      user_id { 1 }
  end
end
