require 'rails_helper'
RSpec.describe '投稿機能', type: :system do
    before do
        @user1 = FactoryBot.create(:user)
        user1_profile = FactoryBot.create(:profile, user_id: @user1.id)
        @user1_post1 = FactoryBot.create(:post, user_id: @user1.id)

        @user2 = FactoryBot.create(:user, email: 'guest@guest.com')
        user2_profile = FactoryBot.create(:profile, name: 'ゲストユーザー', user_id: @user2.id)

        league1 = FactoryBot.create(:league)
        league2 = FactoryBot.create(:league, name: 'リーグ２')

        visit root_path
        click_link 'Log In'
        fill_in 'user[email]', with: 'user@user.com'
        fill_in 'user[password]', with: 'password'
        click_on 'ログイン'
    end

    describe '投稿CRUD機能' do
        context '新規投稿する場合' do
            it '投稿した内容を一覧ページで確認することができる' do
                visit root_path
                click_link '掲示板へ'
                sleep 5
                click_link '投稿する'
                fill_in 'post[content]', with: 'RSpecテスト中'
                click_on '投稿'
                click_link '一覧へ戻る'
                expect(page).to have_content 'みんなの投稿'
                expect(page).to have_content 'テストロボット君'
                expect(page).to have_content 'RSpecテスト中'
            end
            it 'タグ付け投稿した場合は、そのタグを一覧ページで確認することができる' do
              visit root_path
              click_link '掲示板へ'
              click_link '投稿する'
              select 'リーグ１', from: 'label[league]'
              fill_in 'post[content]', with: 'タグを付けて投稿してます！'
              click_on '投稿'
              click_link '一覧へ戻る'
              expect(page).to have_content 'みんなの投稿'
              expect(page).to have_content 'テストロボット君'
              expect(page).to have_content 'リーグ１'
              expect(page).to have_content 'タグを付けて投稿してます！'
            end
        end
        context '投稿を編集する場合' do
            it '内容を編集した投稿を一覧ページで確認することができる' do
                visit root_path
                click_link '掲示板へ'
                click_link '編集', match: :first
                fill_in 'post[content]', with: '編集しました'
                click_on '投稿'
                click_link '一覧へ戻る'
                expect(page).to have_content 'みんなの投稿'
                expect(page).to have_content 'テストロボット君'
                expect(page).to have_content '編集しました'
            end
            it 'タグを変更した投稿を一覧ページで確認することができる' do
              visit root_path
              click_link '掲示板へ'
              click_link '編集', match: :first
              select 'リーグ２', from: 'label[league]'
              click_on '投稿'
              click_link '一覧へ戻る'
              expect(page).to have_content 'みんなの投稿'
              expect(page).to have_content 'テストロボット君'
              expect(page).to have_content 'リーグ２'
              expect(page).to have_content 'test'
            end
        end
        context '投稿を削除する場合' do
            it '投稿をが削除されている' do
                visit root_path
                click_link '掲示板へ'
                click_link '削除', match: :first
                page.driver.browser.switch_to
                accept_confirm
                expect(page).to have_content 'Post was successfully destroyed.'
                expect(page).to have_content 'みんなの投稿'
                expect(page).not_to have_content 'test'
            end
        end
        describe '投稿機能のアクセス制限について' do
          before do
            user3 = FactoryBot.create(:user, email: 'user3@user.com')
            user2_profile = FactoryBot.create(:profile, name: 'ユーザー3号', user_id: user3.id)

            visit root_path
            click_link 'Log Out'
            visit root_path
            click_link 'Log In'
            fill_in 'user[email]', with: 'user3@user.com'
            fill_in 'user[password]', with: 'password'
            click_on 'ログイン'
          end
          context '投稿する場合' do
            it '未ログイン状態ではゲストユーザーとして投稿される' do
              visit root_path
              click_link 'Log Out'
              click_link '掲示板へ'
              sleep 5
              click_link '投稿する'
              fill_in 'post[content]', with: 'RSpecテスト中'
              click_on '投稿'
              click_link '一覧へ戻る'
              expect(page).to have_content 'みんなの投稿'
              expect(page).to have_content 'ゲストユーザー'
              expect(page).to have_content 'RSpecテスト中'
            end
            it 'ログイン状態では投稿したユーザーの名前が表示される' do
              visit root_path
              click_link '掲示板へ'
              click_link '投稿する'
              fill_in 'post[content]', with: '3号が投稿しました'
              click_on '投稿'
              click_link '一覧へ戻る'
              expect(page).to have_content 'みんなの投稿'
              expect(page).to have_content 'ユーザー3号'
              expect(page).to have_content '3号が投稿しました'
            end
          end
          context '投稿を編集する場合' do
            it 'ユーザーは他のユーザーの投稿を編集できない' do
              visit root_path
              click_link '掲示板へ'
              visit edit_post_path(@user1_post1.id)
              expect(page).to have_content '編集権限がありません'
              expect(page).to have_content 'みんなの投稿'
            end
            it '管理者はユーザーの投稿を編集することができる' do
              visit root_path
              click_link 'Log Out'
              visit new_user_session_path
              click_link 'ゲストログイン（閲覧用）'
              visit posts_path
              click_link '編集', match: :first
              fill_in 'post[content]', with: '管理者が編集しました'
              click_on '投稿'
              click_link '一覧へ戻る'
              expect(page).to have_content 'みんなの投稿'
              expect(page).to have_content 'テストロボット君'
              expect(page).to have_content '管理者が編集しました'
            end
          end
          context '投稿を削除する場合' do
            it '管理者はユーザーの投稿を削除することができる' do
              visit root_path
              click_link 'Log Out'
              visit new_user_session_path
              click_link 'ゲストログイン（閲覧用）'
              visit posts_path
              click_link '削除', match: :first
              page.driver.browser.switch_to
              accept_confirm
              expect(page).to have_content 'Post was successfully destroyed.'
              expect(page).to have_content 'みんなの投稿'
              expect(page).not_to have_content 'テストロボット君'
              expect(page).not_to have_content 'test'
            end
          end
        end
    end
end
