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
    # add_index :users, [:user_id]
  end
end
