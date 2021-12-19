require 'rails_helper'
RSpec.describe 'League', type: :system do
  before do
    league1 = FactoryBot.create(:league)

    visit new_user_session_path
    click_link 'ゲストログイン（閲覧用）'
    visit root_path
  end
  describe 'League CRUD機能' do
    context 'Leagueを新規登録する場合' do
      it 'League一覧画面に登録したリーグ名が表示される' do
        visit leagues_path
        click_link 'リーグを新規登録'
        fill_in 'league[name]', with: 'テスト・リーグ'
        fill_in 'league[nationality]', with: 'テスト共和国'
        click_on '登録'
        click_link '一覧へ戻る'
        expect(page).to have_content 'Leagues'
        expect(page).to have_content 'テスト・リーグ'
      end
    end
    context 'Leagueを編集する場合' do
      it '編集したリーグ名が一覧画面に表示される' do
        visit leagues_path
        click_link '編集', match: :first
        fill_in 'league[name]', with: 'Edited・リーグ'
        fill_in 'league[nationality]', with: 'Edited共和国'
        click_on '登録'
        expect(page).to have_content 'League was successfully updated.'
        click_link '一覧へ戻る'
        expect(page).to have_content 'Leagues'
        expect(page).to have_content 'Edited・リーグ'
        expect(page).not_to have_content 'リーグ１'
      end
    end
    context 'Leagueを削除する場合' do
      it '削除されたリーグ名が一覧画面に表示されてない' do
        visit leagues_path
        click_link '削除', match: :first
        page.driver.browser.switch_to
        accept_confirm
        expect(page).to have_content 'League was successfully destroyed.'
        expect(page).to have_content 'Leagues'
        expect(page).not_to have_content 'リーグ１'
      end
    end
  end
end
