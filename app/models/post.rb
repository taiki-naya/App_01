class Post < ApplicationRecord
  has_one_attached :image
  has_many :labelling_of_posts, dependent: :destroy
  belongs_to :user

  def LabellingOfPost.insert(params, post)
    stores = post.labelling_of_posts.where(labelable_type: 'Store')
    leagues = post.labelling_of_posts.where(labelable_type: 'League')
    teams = post.labelling_of_posts.where(labelable_type: 'Team')
    kits = post.labelling_of_posts.where(labelable_type: 'Kit')
    if params[:id].present?
      stores.delete_all if params[:label][:store].present?
      leagues.or(teams).or(kits).delete_all if params[:label][:league].present?
      teams.or(kits).delete_all if params[:label][:team].present?
      kits.delete_all if params[:label][:kit].present?
    end
    params[:label].each do |key, value|
      next unless value.present?
      label = LabellingOfPost.new(post_id: post.id, labelable_type: key.capitalize, labelable_id: value)
      label.save!(validate: false)
    end
  end

end
