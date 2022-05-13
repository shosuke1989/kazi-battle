class Post < ApplicationRecord
    has_many :doits, dependent: :destroy


    validates :content,{presence: true}
    validates :point,{presence: true,numericality: {only_integer: true}}
    validates :family_id, {presence: true}

    def doits
        return Doit.where(post_id: self.id)
    end

end
