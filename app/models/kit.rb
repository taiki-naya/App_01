class Kit < ApplicationRecord
  belongs_to :team
  has_one_attached :image
  has_many :labelling_of_posts, as: :labelable
  has_many :labelling_of_items, as: :labelable

  validates :series, presence: true
end
