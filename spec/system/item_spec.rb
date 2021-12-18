require 'rails_helper'
RSpec.describe 'Item', type: :system do
  before do
    @store1 = FactoryBot.create(:store)
    item1 = FactoryBot.create(:item, store_id: @store1.id)

    visit new_user_session_path
    click_link 'ゲストログイン（閲覧用）'
    visit root_path
  end
  describe 'Item CRUD機能' do
    context 'Itemを新規登録する場合' do
      it 'Item一覧画面に登録した商品名が表示される' do
        visit store_items_path(@store1.id)
        click_link '商品を新規登録'
        fill_in 'item[name]', with: 'テスト・アイテム'
        select 'XL', from: 'item[size]'
        fill_in 'item[price]', with: 10000
        click_on '登録'
        expect(page).to have_content 'Item was successfully created.'
        expect(page).to have_content 'ストア１ 全商品一覧'
        expect(page).to have_content 'テスト・アイテム'
      end
    end
    context 'Itemを編集する場合' do
      it '編集した商品名が一覧画面に表示される' do
        visit store_items_path(@store1.id)
        click_link 'アイテム１'
        click_link '商品情報を編集する'
        fill_in 'item[name]', with: 'Editedアイテム'
        select 'XL', from: 'item[size]'
        fill_in 'item[price]', with: 10000000
        click_on '更新'
        expect(page).to have_content 'Item was successfully updated.'
        click_link '一覧へ戻る'
        expect(page).to have_content 'ストア１ 全商品一覧'
        expect(page).to have_content 'Editedアイテム'
        expect(page).not_to have_content 'アイテム１'
      end
    end
    context 'Itemを削除する場合' do
      it '削除された商品名が一覧画面に表示されてない' do
        visit store_items_path(@store1.id)
        click_link 'アイテム１'
        click_link '商品情報を削除する'
        page.driver.browser.switch_to
        accept_confirm
        expect(page).to have_content 'Item was successfully destroyed.'
        expect(page).to have_content 'ストア１ 全商品一覧'
        expect(page).not_to have_content 'アイテム１'
      end
    end
  end
end
