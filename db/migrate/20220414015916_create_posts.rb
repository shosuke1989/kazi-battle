class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.string :content
      t.integer :point
      t.integer :post_point
      t.integer :family_id


      t.timestamps
    end
  end
end
