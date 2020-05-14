require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do

  before do
    user = FactoryBot.create(:user)
    task1 = FactoryBot.create(:task, user: user)
    task2 = FactoryBot.create(:second_task, user: user)
    label1 = FactoryBot.create(:label)
    label2 = FactoryBot.create(:label2)
    label3 = FactoryBot.create(:label3)
    label4 = FactoryBot.create(:label4)
    label5 = FactoryBot.create(:label5)
    TaskLabel.create(task_id: task1.id, label_id: label1.id)
    TaskLabel.create(task_id: task2.id, label_id: label2.id)

  end

  describe 'タスク一覧画面' do
    context 'タスクを作成した場合' do
      it '作成済みのタスクが表示される' do
        visit new_session_path
        fill_in 'Email', with: 'sample@example.com'
        fill_in 'Password', with: '00000000'
        click_on 'Log in'
        visit tasks_path
        expect(page).to have_content 'Factoryで作ったデフォルトのタイトル１'
        expect(page).to have_content 'Factoryで作ったデフォルトのコンテント1'
        expect(page).to have_content 'sample1'
        expect(page).to have_content 'Factoryで作ったデフォルトのタイトル2'
        expect(page).to have_content 'Factoryで作ったデフォルトのコンテント2'
        expect(page).to have_content 'sample2'

      end
    end
    context '複数のタスクを作成した場合' do
      it 'タスクが作成日時の降順に並んでいる' do 
          visit new_session_path
          fill_in 'Email', with: 'sample@example.com'
          fill_in 'Password', with: '00000000'
          click_on 'Log in'       
          visit tasks_path
          task_list = all('tbody tr') 
          expect(task_list[0]).to have_content 'Factoryで作ったデフォルトのタイトル2'
          expect(task_list[1]).to have_content 'Factoryで作ったデフォルトのタイトル１'
          expect(task_list[0]).to have_content 'sample2'
          expect(task_list[1]).to have_content 'sample1'
        end
      end
   end  

   describe 'タスク登録画面' do
    context '必要項目を入力して、createボタンを押した場合' do
      it 'データが保存される' do
      visit new_session_path
      fill_in 'Email', with: 'sample@example.com'
      fill_in 'Password', with: '00000000'
      click_on 'Log in'
      visit new_task_path
      fill_in "タイトル", with: 'Factoryで作ったデフォルトのタイトル１'
      fill_in "内容", with: 'Factoryで作ったデフォルトのコンテント1'
      fill_in "終了期限", with:  Time.new(2020,6,20)
      select '着手中', from: 'ステータス'
      select '高', from: '優先順位'
      check 'sample1'
      check 'sample2'
      click_button '登録する'
      expect(page).to have_content 'タスクを作成しました'
      expect(page).to have_content 'Factoryで作ったデフォルトのタイトル１'
      expect(page).to have_content 'Factoryで作ったデフォルトのコンテント1'
      expect(page).to have_content '2020-06-20'
      expect(page).to have_content '着手中'
      expect(page).to have_content '高'
      expect(page).to have_content 'sample1'
      expect(page).to have_content 'sample2'
    end
    end
  end
end