class Item < ApplicationRecord
  belongs_to :store
  has_many :labelling_of_items, dependent: :destroy
  has_one_attached :image

  enum size: { Kids: 0, XS: 1, S: 2, M: 3, L: 4, XL: 5, XXL: 6 }

  def LabellingOfItem.insert(params, item)
    leagues = item.labelling_of_items.where(labelable_type: 'League')
    teams = item.labelling_of_items.where(labelable_type: 'Team')
    kits = item.labelling_of_items.where(labelable_type: 'Kit')
    if params[:id].present?
      leagues.or(teams).or(kits).delete_all if params[:label][:league].present?
      teams.or(kits).delete_all if params[:label][:team].present?
      kits.delete_all if params[:label][:kit].present?
    end
    params[:label].each do |key, value|
      next unless value.present?
      label = LabellingOfItem.new(item_id: item.id, labelable_type: key.capitalize, labelable_id: value)
      label.save!(validate: false)
    end
  end

end
