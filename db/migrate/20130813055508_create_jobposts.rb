class CreateJobposts < ActiveRecord::Migration
  def change
    create_table :jobposts do |t|
      t.string :post_title
      t.string :city_state
      t.integer :country_id
      t.string :referrer_code
      t.integer :user_id

      t.timestamps
    end
    add_index :microposts, [:user_id, :created_at]
  end
end
