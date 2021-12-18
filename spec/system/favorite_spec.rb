require 'rails_helper'
RSpec.describe 'favorite', type: :system do
  before do
    league1 = FactoryBot.create(:league)
    team1 = FactoryBot.create(:team, league_id: league1.id)
    team2 = FactoryBot.create(:team, name: 'チーム２', league_id: league1.id)

    @user1 = FactoryBot.create(:user)
    user1_profile = FactoryBot.create(:profile, user_id: @user1.id)
    user1_favorite = FactoryBot.create(:favorite,user_id: @user1.id, favoritable_id: team2.id)

    visit root_path
    click_link 'Log In'
    fill_in 'user[email]', with: 'user@user.com'
    fill_in 'user[password]', with: 'password'
    click_on 'ログイン'
  end
  describe 'お気に入り機能' do
    context 'お気に入りを追加する場合' do
      it 'マイページにお気に入りが表示される' do
        visit root_path
        find('label[for=tab_1]').click
        click_link 'チーム１'
        click_link 'お気に入りする'
        expect(page).to have_content 'チーム１をお気に入り登録しました'
        click_link 'YourProfile'
        sleep 5
        expect(page).to have_content 'あなたのお気に入り :'
        expect(page).to have_content 'チーム１'
      end
    end
    context 'お気に入りを解除する場合' do
      it 'マイページのお気に入りが削除される' do
        visit root_path
        click_link 'YourProfile'
        sleep 5
        expect(page).to have_content 'あなたのお気に入り :'
        expect(page).to have_content 'チーム２'
        click_link 'KitCommu'
        find('label[for=tab_1]').click
        click_link 'チーム２'
        click_link 'お気に入り解除する'
        expect(page).to have_content 'チーム２をお気に入り解除しました'
        click_link 'YourProfile'
        sleep 5
        expect(page).to have_content 'あなたのお気に入り :'
      end
    end
  end
end
