class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.string :CRNumber
      t.date :date
      t.string :year
      t.string :description
      t.string :victim
      t.string :location
      t.string :category

      t.timestamps null: false
    end
  end
end
