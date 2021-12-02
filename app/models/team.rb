class Team < ApplicationRecord
  belongs_to :league
  has_many :kits, dependent: :destroy
end
