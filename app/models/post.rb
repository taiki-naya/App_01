class Post < ApplicationRecord
  has_one_attached :image
  has_many :labelling_of_posts, dependent: :destroy
end
