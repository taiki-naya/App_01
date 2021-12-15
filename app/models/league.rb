class League < ApplicationRecord
  has_many :teams, dependent: :destroy
  has_many :labelling_of_posts, as: :labelable
  has_many :labelling_of_items, as: :labelable
  has_many :favorites, as: :favoritable
end
