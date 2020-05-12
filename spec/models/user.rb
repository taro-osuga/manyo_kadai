require 'rails_helper'
RSpec.describe 'ユーザー管理機能', type: :model do
  it 'nameが空ならバリデーションが通らない' do
    user = User.new(name: '', email: 'test1@test.com',password: 'test1@test.com')
    expect(user).not_to be_valid
  end
  it 'emailが空ならバリデーションが通らない' do
    user = User.new(name: 'test1@test.com', email: '',password: 'test1@test.com')
    expect(user).not_to be_valid
  end
  it 'passwordが空ならバリデーションが通らない' do
    user = User.new(name: 'test1@test.com', email: 'test1@test.com',password: '')
    expect(user).not_to be_valid
  end
  it 'nameとemailとパスワードが記載されていればバリデーションが通る' do
    user = User.new(name: 'test1@test.com', email: 'test1@test.com', password: 'test1@test.com')
    expect(user).to be_valid
  end
end