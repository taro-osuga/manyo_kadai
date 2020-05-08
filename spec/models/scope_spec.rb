require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :model do
context 'scopeメソッドで検索をした場合' do
    before do
      Task.create(title: "task", content: "sample_task",status: "未着手")
      Task.create(title: "sample", content: "sample_sample",status: "完了")
    end
    it "scopeメソッドでタイトル検索ができる" do
      expect(Task.search_title('task').count).to eq 1
    end
    it "scopeメソッドでステータス検索ができる" do
        expect(Task.search_status('未着手').count).to eq 1
    end
    it "scopeメソッドでタイトルとステータスの両方が検索できる" do
        expect(Task.search_title('sample').search_status('完了').count).to eq 1
    end
  end
end