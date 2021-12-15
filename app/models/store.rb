class Store < ApplicationRecord
  has_many :items, dependent: :destroy
  has_many :labelling_of_posts, as: :labelable
  has_many :favorites, as: :favoritable
end
