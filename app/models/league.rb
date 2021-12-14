class League < ApplicationRecord
  has_many :teams, dependent: :destroy
  has_many :labelling_of_posts, as: :labelable
end
