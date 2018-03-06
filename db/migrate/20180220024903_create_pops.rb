class CreatePops < ActiveRecord::Migration[5.1]
  def change
    create_table :pops, id: false do |t|
      t.primary_key :id, :uuid, :default => 'uuid_generate_v1()'	
      t.string :name
      t.string :ip
      t.string :instance


      t.timestamps
    end
  end
end
