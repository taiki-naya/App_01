require 'rails_helper'
RSpec.describe 'Store', type: :system do
  before do
    store1 = FactoryBot.create(:store)

    visit new_user_session_path
    click_link 'ゲストログイン（閲覧用）'
    visit root_path
  end
  describe 'Store CRUD機能' do
    context 'Storeを新規登録する場合' do
      it 'Store一覧画面に登録したストア名が表示される' do
        visit stores_path
        click_link 'ストアを新規登録'
        fill_in 'store[name]', with: 'テスト・ストア'
        fill_in 'store[link]', with: 'http://test_store.com'
        click_on '登録'
        click_link '一覧へ戻る'
        expect(page).to have_content 'ストア一覧'
        expect(page).to have_content 'テスト・ストア'
        expect(page).to have_content 'http://test_store.com'
      end
    end
    context 'Storeを編集する場合' do
      it '編集したストア名が一覧画面に表示される' do
        visit stores_path
        click_link '編集', match: :first
        fill_in 'store[name]', with: 'Editedストア'
        fill_in 'store[link]', with: 'https://edited_store.com'
        click_on '登録'
        expect(page).to have_content 'Store was successfully updated.'
        click_link '一覧へ戻る'
        expect(page).to have_content 'ストア一覧'
        expect(page).to have_content 'Editedストア'
        expect(page).to have_content 'https://edited_store.com'
        expect(page).not_to have_content 'ストア１'
      end
    end
    context 'Storeを削除する場合' do
      it '削除されたストア名が一覧画面に表示されてない' do
        visit stores_path
        click_link '削除', match: :first
        page.driver.browser.switch_to
        accept_confirm
        expect(page).to have_content 'Store was successfully destroyed.'
        expect(page).to have_content 'ストア一覧'
        expect(page).not_to have_content 'ストア１'
      end
    end
  end
end
