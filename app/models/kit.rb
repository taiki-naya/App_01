class Kit < ApplicationRecord
  belongs_to :team
  has_one_attached :image
  has_many :labelling_of_posts, as: :labelable
end
