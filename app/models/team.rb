class Team < ApplicationRecord
  belongs_to :league
  has_many :kits, dependent: :destroy
  has_many :labelling_of_posts, as: :labelable
  has_many :labelling_of_items, as: :labelable
  has_many :favorites, as: :favoritable

  has_one_attached :image

  validates :name, presence: true
  # validates :established, numericality: {greater_than_or_equal_to: 1850, less_than_or_equal_to: Date.today.to_s.slice(0..3).to_i}

  def self.import(file, league)
    CSV.foreach(file.path, headers: true) do |row|
      team =  new
      row_hash = row.to_hash.slice(*updatable_attributes)
      team.attributes = row_hash
      team.league_id = league
      team.save!(validate: false)
    end
  end

  private
  def self.updatable_attributes
    ['name', 'home_town', 'link', 'twitter_acount']
  end
end
