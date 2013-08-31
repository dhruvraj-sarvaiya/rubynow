class CreateJobpostdetails < ActiveRecord::Migration
  def change
    create_table :jobpostdetails do |t|
      t.string :company
      t.string :company_url
      t.string :description
      t.integer :type_of_position
      t.integer :work_hours
      t.string :how_to_apply
      t.integer :jobpost_id

      t.timestamps
    end
    add_index :jobposts, [:jobpost_id]
  end
end
