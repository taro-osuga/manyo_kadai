require 'rails_helper'
RSpec.describe 'ユーザ登録・ログイン・ログアウト機能', type: :system do
  describe 'ユーザ登録のテスト' do
    context 'ユーザのデータがなくログインしていない場合' do
      it 'ユーザ新規登録のテスト' do
        visit new_user_path
        fill_in 'user[name]', with: 'sample'
        fill_in 'user[email]', with: 'sample@example.com'
        fill_in 'user[password]', with: '00000000'
        fill_in 'user[password_confirmation]', with: '00000000'
        click_on 'Create my account'
        expect(current_path).to eq user_path(id: 1)
      end
      it 'ログインしていない時はログイン画面に飛ぶテスト' do
        visit tasks_path
        expect(current_path).to eq root_path
      end
    end
  end
  describe 'セッション機能のテスト' do
    context 'ユーザのデータがありログインしていない場合' do
      it 'ログインが出来ること'do
        FactoryBot.create(:user)
        visit new_session_path
        fill_in 'Email', with: 'sample@example.com'
        fill_in 'Password', with: '00000000'
        click_on 'Log in'
        expect(page).to have_content 'ログインしました'
      end
      it '自分の詳細画面(マイページ)に飛べること' do
        FactoryBot.create(:user)
        visit new_session_path
        fill_in 'Email', with: 'sample@example.com'
        fill_in 'Password', with: '00000000'
        click_on 'Log in'
        expect(page).to have_content 'sampleのページ'
      end
      it '一般ユーザが他人の詳細画面に飛ぶとタスク一覧ページに遷移すること' do
        FactoryBot.create(:user)
        visit new_session_path
        fill_in 'Email', with: 'sample@example.com'
        fill_in 'Password', with: '00000000'
        click_on 'Log in'
        visit user_path(id:2)
        expect(page).to have_content 'タスク一覧'
      end
      it 'ログアウトができること' do
        FactoryBot.create(:user)
        visit new_session_path
        fill_in 'Email', with: 'sample@example.com'
        fill_in 'Password', with: '00000000'
        click_on 'Log in'
        click_on 'Logout'
        expect(page).to have_content 'ログアウトしました'
      end
    end
  end
end