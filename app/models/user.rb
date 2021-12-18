class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

         has_one :profile, dependent: :destroy
         has_many :favorites, dependent: :destroy
         has_many :posts, dependent: :destroy
         accepts_nested_attributes_for :profile

   def self.guest_user
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.admin = true
      @profile = user.build_profile(name: 'ゲストログインユーザー')
    end
   end

end
