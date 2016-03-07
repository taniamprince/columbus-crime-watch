class AddYear < ActiveRecord::Migration
  def change
  	# add_column table_name, :column_name, :column_type
    add_column :reports, :year, :string
  end
end
