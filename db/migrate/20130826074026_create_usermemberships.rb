class CreateUsermemberships < ActiveRecord::Migration
  def change
    create_table :usermemberships do |t|
      t.integer :user_id
      t.integer :payment_id
      t.integer :post_type
      t.integer :status
      t.timestamps :start_date
      t.timestamps :end_date

      t.timestamps
    end

    add_index :users, [:user_id]
    add_index :payments, [:payment_id]
  end
end
