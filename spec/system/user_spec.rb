require 'rails_helper'
RSpec.describe 'ユーザー機能', type: :system do
    before do
        @user1 = FactoryBot.create(:user)
        user1_profile = FactoryBot.create(:profile, user_id: @user1.id)
        @user2 = FactoryBot.create(:user, email: 'user2@user.com')
        user2_profile = FactoryBot.create(:profile, user_id: @user2.id)
    end

    describe 'ユーザー情報のCRUD機能' do
        context 'ユーザーを新規登録した場合' do
            it '新規登録後、トップページに遷移される' do
                visit root_path
                click_link 'Sign Up'
                fill_in 'user[profile_attributes][name]', with: 'ゲストユーザー'
                fill_in 'user[email]', with: 'guest@user.com'
                fill_in 'user[password]', with: 'useruser'
                fill_in 'user[password_confirmation]', with: 'useruser'
                click_on '新規登録'
                expect(page).to have_content 'アカウント登録が完了しました。'
                expect(page).to have_content '新着ユニフォーム'
            end
        end
        context 'ユーザー情報を編集した場合' do
            it '変更した情報でログインができる' do
                visit root_path
                click_link 'Log In'
                fill_in 'user[email]', with: 'user@user.com'
                fill_in 'user[password]', with: 'password'
                click_on 'ログイン'
                click_link 'YourProfile'
                sleep 5
                click_button '登録情報の変更'
                fill_in 'user[password]', with: 'useruser'
                fill_in 'user[password_confirmation]', with: 'useruser'
                fill_in 'user[current_password]', with: 'password'
                click_on '更新'
                click_link 'Log Out'
                click_link 'Log In'
                fill_in 'user[email]', with: 'user@user.com'
                fill_in 'user[password]', with: 'useruser'
                click_on 'ログイン'
                expect(page).to have_content 'ログインしました。'
                expect(page).to have_content '新着ユニフォーム'
            end
        end
        context 'ユーザー情報を削除した場合' do
            it '削除したユーザーではログインできない' do
                visit root_path
                click_link 'Log In'
                fill_in 'user[email]', with: 'user@user.com'
                fill_in 'user[password]', with: 'password'
                click_on 'ログイン'
                click_link 'YourProfile'
                click_button '登録情報の変更'
                click_on 'アカウント削除'
                page.driver.browser.switch_to
                accept_confirm
                accept_confirm
                expect(page).to have_content 'アカウントを削除しました。'
                click_link 'Log In'
                fill_in 'user[email]', with: 'user@user.com'
                fill_in 'user[password]', with: 'password'
                click_on 'ログイン'
                expect(page).to have_content 'メールアドレス もしくはパスワードが不正です。'
            end
        end
    end

    describe 'ログイン，ログアウト機能' do
        context 'ログインする場合' do
            it 'ログイン後にトップページに遷移されている' do
                visit root_path
                click_link 'Log In'
                fill_in 'user[email]', with: 'user@user.com'
                fill_in 'user[password]', with: 'password'
                click_on 'ログイン'
                expect(page).to have_content 'ログインしました。'
                expect(page).to have_content '新着ユニフォーム'
            end
        end
        context 'ログアウトする場合' do
            it 'ログアウト後にトップページに遷移されている' do
                visit root_path
                click_link 'Log In'
                fill_in 'user[email]', with: 'user@user.com'
                fill_in 'user[password]', with: 'password'
                click_on 'ログイン'
                click_link 'Log Out'
                expect(page).to have_content 'ログアウトしました。'
                expect(page).to have_content '新着ユニフォーム'
            end
        end
    end

    describe 'ゲストユーザー機能' do
        context 'ゲストユーザーでログインする場合' do
            it 'ログイン後にトップページに遷移されている' do
                visit root_path
                click_link 'Log In'
                click_link 'ゲストログイン（閲覧用）'
                expect(page).to have_content 'ゲストユーザーとしてログインしました。'
                expect(page).to have_content '新着ユニフォーム'
            end
        end
    end
    describe 'アクセス制限について' do
        context 'ログインしていない場合' do
            it 'マイページにアクセスすることができない' do
                visit root_path
                visit profile_path(id: @user1.id)
                expect(page).to have_content '閲覧権限がありません'
                expect(page).to have_content '新着ユニフォーム'
            end
        end
        context 'ログイン状態で他人のマイページにアクセスする場合' do
            it '他人のマイページにアクセスすることができない' do
                visit root_path
                click_link 'Log In'
                fill_in 'user[email]', with: 'user@user.com'
                fill_in 'user[password]', with: 'password'
                click_on 'ログイン'
                visit profile_path(id: @user2.id)
                expect(page).to have_content '閲覧権限がありません'
                expect(page).to have_content '新着ユニフォーム'
            end
        end
    end
end
