class AddPostTypeToJobposts < ActiveRecord::Migration
  def change
  	add_column :jobposts, :post_type, :integer, :default => 1
  end
end
