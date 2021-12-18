FactoryBot.define do
  factory :favorite do
    user_id { 1 }
    favoritable_type { 'Team' }
    favoritable_id { 1 }
  end
end
