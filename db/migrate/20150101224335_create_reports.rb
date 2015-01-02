class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.string :CRNumber
      t.string :date
      t.string :description
      t.string :victim
      t.string :location

      t.timestamps null: false
    end
  end
end
