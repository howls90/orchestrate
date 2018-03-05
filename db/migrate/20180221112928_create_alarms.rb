class CreateAlarms < ActiveRecord::Migration[5.1]
  def change
    create_table :alarms, id: :uuid do |t|
      t.string :name      
      t.belongs_to :vnf, index: true  

      t.timestamps
    end
  end
end
