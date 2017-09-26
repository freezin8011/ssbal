class CreatePanelties < ActiveRecord::Migration
  def change
    create_table :panelties do |t|
      
        t.belongs_to :day
        
        t.string :name
        
        t.integer :money
        t.integer :status
        t.integer :day_id
        
      t.timestamps null: false
    end
  end
end
