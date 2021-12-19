class Store < ApplicationRecord
  has_many :items, dependent: :destroy
  has_many :labelling_of_posts, as: :labelable
  has_many :favorites, as: :favoritable

  validates :name, presence: true, uniqueness: true
  validates :link, format: { with: %r(https?://[\w!?/\+\-_~=;\.,*&@#$%\(\)\'\[\]]+) }
end
