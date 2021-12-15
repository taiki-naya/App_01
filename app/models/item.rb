class Item < ApplicationRecord
  belongs_to :store
  has_many :labelling_of_items, dependent: :destroy
  has_one_attached :image
end
