class User < ApplicationRecord
    validates :family, {presence: true}
    #validates :first_name, {presence: true}
  
    #validates :email,{presence: true}
    validates :email,{presence: true,uniqueness: true}
    validates :password,{presence: true}

    def sumpoint
        return Doit.where(firstname_id:self.id).sum(:post_point)
    end

  
end
