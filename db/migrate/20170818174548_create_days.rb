class CreateDays < ActiveRecord::Migration
  def change
    create_table :days do |t|
      
        t.string :month
        t.string :day
        t.integer :total
        t.integer :receive
        t.string :day_written_by

      t.timestamps null: false
    end
  end
end
