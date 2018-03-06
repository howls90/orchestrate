class CreateScenarios < ActiveRecord::Migration[5.1]
  def change
    create_table :scenarios, id: false do |t|
      t.primary_key :id, :uuid, :default => 'uuid_generate_v1()'	
      t.string :name
      t.text   :description

      t.timestamps
    end
  end
end
