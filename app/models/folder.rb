class Folder < ApplicationRecord
    belongs_to :user
    has_many :passwords, -> { order 'name ASC' }, dependent: :destroy

    validates :name, presence: true
    validates :name, uniqueness: true
end
