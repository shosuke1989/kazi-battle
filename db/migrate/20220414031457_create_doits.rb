class CreateDoits < ActiveRecord::Migration[6.0]
  def change
    create_table :doits do |t|
      t.integer :firstname_id
      t.integer :post_id
      t.integer :user_id
      t.integer :post_point
      
      t.timestamps
    end
  end
end
