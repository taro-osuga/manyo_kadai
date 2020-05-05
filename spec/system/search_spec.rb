require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do

  before do
    FactoryBot.create(:task)
    FactoryBot.create(:second_task)
    FactoryBot.create(:third_task)
  end

    describe 'タスク一覧画面' do
      context '検索をした場合' do
        it "タイトルで検索できる" do
          visit tasks_path
          fill_in "タイトル検索", with: 'タイトル１'
          click_button '検索'
          expect(page).to have_content 'タイトル１'
        end
      end
      context '検索をした場合' do
        it "ステータスで検索できる" do
          visit tasks_path
          select '完了', from: 'status'
          click_button '検索'
          expect(find(".status")).to have_content "完了"
        end
      end
      context '検索をした場合' do
        it "タイトルとステータスで検索できる" do
          visit tasks_path
          fill_in "タイトル検索", with: 'タイトル3'
          select '着手中', from: 'status'
          click_button '検索'
          expect(page).to have_content 'タイトル3'
          expect(find(".status")).to have_content "着手中"
        end
      end
    end
end