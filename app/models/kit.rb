class Kit < ApplicationRecord
  belongs_to :team
  has_one_attached :image
end
