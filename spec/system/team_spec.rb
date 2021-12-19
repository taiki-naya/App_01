require 'rails_helper'
RSpec.describe 'Team', type: :system do
  before do
    @league1 = FactoryBot.create(:league)
    team1 = FactoryBot.create(:team, league_id: @league1.id)

    visit new_user_session_path
    click_link 'ゲストログイン（閲覧用）'
    visit root_path
  end
  describe 'Team CRUD機能' do
    context 'Teamを新規登録する場合' do
      it 'Team一覧画面に登録したチーム名が表示される' do
        visit league_teams_path(@league1.id)
        click_link 'チームを新規登録'
        fill_in 'team[name]', with: 'テスト・チーム'
        fill_in 'team[home_town]', with: 'テスト市'
        fill_in 'team[established]', with: 1900
        click_on '入力フォームから登録'
        expect(page).to have_content 'リーグ１'
        expect(page).to have_content 'テスト・チーム'
        expect(page).to have_content 'テスト市'
      end
    end
    context 'Teamを編集する場合' do
      it '編集したチーム名が一覧画面に表示される' do
        visit league_teams_path(@league1.id)
        click_link '編集', match: :first
        fill_in 'team[name]', with: 'Editedチーム'
        fill_in 'team[home_town]', with: 'Edited市'
        click_on '更新'
        click_link '一覧へ戻る'
        expect(page).to have_content 'リーグ１'
        expect(page).to have_content 'Editedチーム'
        expect(page).to have_content 'Edited市'
        expect(page).not_to have_content 'チーム１'
      end
    end
    context 'Teamを削除する場合' do
      it '削除されたチーム名が一覧画面に表示されてない' do
        visit league_teams_path(@league1.id)
        click_link '削除', match: :first
        page.driver.browser.switch_to
        accept_confirm
        expect(page).to have_content 'Team was successfully destroyed.'
        expect(page).to have_content 'リーグ１'
        expect(page).not_to have_content 'チーム１'
      end
    end
  end
end
