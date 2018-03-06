class CreateRrhs < ActiveRecord::Migration[5.1]
  def change
    create_table :rrhs, id: false do |t|
      t.primary_key :id, :uuid, :default => 'uuid_generate_v1()'
      t.string :model
      t.string :ip
      t.string :version
      t.float  :latitude
      t.float  :longitude
      t.uuid :scenario_id

      t.timestamps
    end
  end
end
