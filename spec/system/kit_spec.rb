require 'rails_helper'
RSpec.describe 'Kit', type: :system do
  before do
    @league1 = FactoryBot.create(:league)
    @team1 = FactoryBot.create(:team, league_id: @league1.id)
    @kit1 = FactoryBot.create(:kit, team_id: @team1.id)

    visit new_user_session_path
    click_link 'ゲストログイン（閲覧用）'
    visit root_path
  end
  describe 'Kit CRUD機能' do
    context 'Kitを新規登録する場合' do
      it 'Kit一覧画面に登録したユニフォーム名が表示される' do
        visit league_team_kits_path(@league1.id, @team1.id)
        click_link 'ユニフォームを登録'
        fill_in 'kit[series]', with: 'テスト・キット'
        click_on '登録'
        expect(page).to have_content 'チーム１のユニフォーム一覧'
        expect(page).to have_content 'テスト・キット'
      end
    end
    context 'Kitを編集する場合' do
      it '編集したキット名が一覧画面に表示される' do
        visit league_team_kits_path(@league1.id, @team1.id)
        click_link '編集', match: :first
        fill_in 'kit[series]', with: 'Editedキット'
        click_on '更新'
        expect(page).to have_content 'Kit was successfully updated.'
        click_link '一覧画面へ戻る'
        expect(page).to have_content 'チーム１のユニフォーム一覧'
        expect(page).to have_content 'Editedキット'
        expect(page).not_to have_content 'キット１'
      end
    end
    context 'Kitを削除する場合' do
      it '削除されたキット名が一覧画面に表示されてない' do
        visit league_team_kits_path(@league1.id, @team1.id)
        click_link '削除', match: :first
        page.driver.browser.switch_to
        accept_confirm
        expect(page).to have_content 'Kit was successfully destroyed.'
        expect(page).to have_content 'チーム１のユニフォーム一覧'
        expect(page).not_to have_content 'キット１'
      end
    end
  end
end
