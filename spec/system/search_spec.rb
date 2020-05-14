require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  before do
    user = FactoryBot.create(:user)
    task1 = FactoryBot.create(:task, user: user)
    task2 = FactoryBot.create(:second_task, user: user)
    task3 = FactoryBot.create(:third_task, user: user)
    label1 = FactoryBot.create(:label)
    label2 = FactoryBot.create(:label2)
    label3 = FactoryBot.create(:label3)
    label4 = FactoryBot.create(:label4)
    label5 = FactoryBot.create(:label5)
    TaskLabel.create(task_id: task1.id, label_id: label1.id)
    TaskLabel.create(task_id: task2.id, label_id: label2.id)
  end

    describe 'タスク一覧画面' do
      context '検索をした場合' do
        it "タイトルで検索できる" do
          visit new_session_path
          fill_in 'Email', with: 'sample@example.com'
          fill_in 'Password', with: '00000000'
          click_on 'Log in'       
          visit tasks_path
          fill_in "タイトル検索", with: 'タイトル１'
          click_on '検索'
          expect(page).to have_content 'タイトル１'
        end
      end
      context '検索をした場合' do
        it "ステータスで検索できる" do
          visit new_session_path
          fill_in 'Email', with: 'sample@example.com'
          fill_in 'Password', with: '00000000'
          click_on 'Log in'       
          visit tasks_path
          select '完了', from: 'status'
          click_button '検索'
          expect(page).to have_content "完了"
        end
      end
      context '検索をした場合' do
        it "タイトルとステータスで検索できる" do
          visit new_session_path
          fill_in 'Email', with: 'sample@example.com'
          fill_in 'Password', with: '00000000'
          click_on 'Log in'       
          visit tasks_path
          fill_in "タイトル検索", with: 'タイトル3'
          select '着手中', from: 'status'
          click_button '検索'
          expect(page).to have_content 'タイトル3'
        end
      end
      context '検索をした場合' do
        it "ラベルで検索できる" do
          visit new_session_path
          fill_in 'Email', with: 'sample@example.com'
          fill_in 'Password', with: '00000000'
          click_on 'Log in'       
          visit tasks_path
          check 'sample1'
          click_button '検索'
          expect(page).to have_content 'sample1'
        end
      end
      context '検索をした場合' do
        it "タイトルとステータスで検索できる" do
          visit new_session_path
          fill_in 'Email', with: 'sample@example.com'
          fill_in 'Password', with: '00000000'
          click_on 'Log in'       
          visit tasks_path
          fill_in "タイトル検索", with: 'タイトル3'
          select '着手中', from: 'status'
          check 'sample1'
          click_button '検索'
          expect(page).to have_content 'タイトル3'
          expect(page).to have_content 'sample1'
        end
      end
      context '終了期限でソートをした場合', :retry => 3 do
        it "並び替えできる" do
          visit new_session_path
          fill_in 'Email', with: 'sample@example.com'
          fill_in 'Password', with: '00000000'
          click_on 'Log in'       
          visit tasks_path
          click_on '終了期限でソートする'
          task_list = all('tbody tr') 
          expect(task_list[0]).to have_content '2020-05-05'
          expect(task_list[1]).to have_content '2020-05-06'
          expect(task_list[2]).to have_content '2020-05-07'
        end
      end
    
      context '重要度でソートをした場合', :retry => 3 do
        it "並び替えできる" do
          visit new_session_path
          fill_in 'Email', with: 'sample@example.com'
          fill_in 'Password', with: '00000000'
          click_on 'Log in'       
          visit tasks_path
          click_link '優先順位でソートする'
          task_list = all('tbody tr') 
           expect(task_list[0]).to have_content '高'
           expect(task_list[1]).to have_content '中'
           expect(task_list[2]).to have_content '下'
        end
      end
    end
end