class ColumnType < ActiveRecord::Migration
  def change
  	change_column :reports, :date,  :string
  end
end
