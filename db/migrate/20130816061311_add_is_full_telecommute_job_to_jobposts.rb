class AddIsFullTelecommuteJobToJobposts < ActiveRecord::Migration
  def change
  	add_column :jobposts, :is_full_telecommute_job, :boolean, :default => false
  end
end
