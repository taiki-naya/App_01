class Team < ApplicationRecord
  belongs_to :league
  has_many :kits, dependent: :destroy

  has_one_attached :image

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
    ['name', 'home_town']
  end
end
