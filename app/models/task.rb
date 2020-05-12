class Task < ApplicationRecord
    validates :title, presence: true
    validates :content, presence: true
    belongs_to :user, optional: true

    scope :search_title, -> (title) { where("title LIKE ?", "%#{ title }%") }
    scope :search_status, -> (status) { where(status: status) }
    scope :search_labels, -> (task_id) { where(id: [task_id]) }

    enum priority:{
        高: 0, #高い
        中: 1, #普通
        下: 2, #低い
      }

    has_many :task_labels, dependent: :destroy, foreign_key: 'task_id'
    has_many :labels, through: :task_labels, source: :label
end
