class Task < ApplicationRecord
    validates :title, presence: true
    validates :content, presence: true
    belongs_to :user, optional: true

    scope :search_title, -> (title) { where("title LIKE ?", "%#{ title }%") }
    scope :search_status, -> (status) { where(status: status) }

    enum priority:{
        高: 0, #高い
        中: 1, #普通
        下: 2, #低い
      }
end
