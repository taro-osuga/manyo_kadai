class Task < ApplicationRecord
    validates :title, presence: true
    validates :content, presence: true
    #  default_scope -> { order(created_at: :desc) }
    # def self.search(search)
    #     search ? where('title LIKE ? OR status LIKE ? ', "%#{search}%", "%#{search}%") : all
    #     # search ? where('status = ?', "%#{search}%") : all
    # end
    scope :search_title, -> (title) { where("title LIKE ?", "%#{ title }%") }
    scope :search_status, -> (status) { where(status: status) }
end
