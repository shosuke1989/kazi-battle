class Firstname < ApplicationRecord
    has_many :doits, dependent: :destroy

    validates :user_id, {presence: true}
    validates :name, {presence: true}  
end
