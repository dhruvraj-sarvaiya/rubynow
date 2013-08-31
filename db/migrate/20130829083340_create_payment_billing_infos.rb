class CreatePaymentBillingInfos < ActiveRecord::Migration
  def change
    create_table :payment_billing_infos do |t|
      t.integer :payment_id
      t.string :first_name
      t.string :last_name
      t.string :add_1
      t.string :add_2
      t.string :state
      t.integer :country_id
      t.string :city
      t.string :zip
      t.string :phone

      t.timestamps
    end
    add_index :payments, [:payment_id]
  end
end
