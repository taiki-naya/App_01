class LabellingOfPost < ApplicationRecord
  belongs_to :post
  belongs_to :labelable, polymorphic: true
end
