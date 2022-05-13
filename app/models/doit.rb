class Doit < ApplicationRecord
    belongs_to :post
    belongs_to :firstname


    validates :firstname_id, {presence: true}
    validates :post_id, {presence: true}  
    validates :user_id, {presence: true}  
    validates :post_point, {presence: true}  
end
