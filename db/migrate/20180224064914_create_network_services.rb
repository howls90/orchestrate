class CreateNetworkServices < ActiveRecord::Migration[5.1]
  def change
    create_table :network_services, id: false do |t|
      t.primary_key :id, :uuid, :default => 'uuid_generate_v1()'	
      t.string :name
      t.uuid :user_id
      t.timestamps
    end
  end
end
