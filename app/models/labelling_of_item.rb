class LabellingOfItem < ApplicationRecord
  belongs_to :item
  belongs_to :labelable, polymorphic: true
end
