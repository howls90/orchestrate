class CreateVnfs < ActiveRecord::Migration[5.1]
  def change
    create_table :vnfs, id: false do |t|
      t.primary_key :id, :uuid, :default => 'uuid_generate_v1()'
      t.string :name
      t.text :description
      t.integer :cores, null: false
      t.integer :ram, null: false
      t.integer :disc, null: false
      t.string  :url_server
      t.string  :url_monitoring
      t.string  :url_logging
      t.string  :status, null: false, default: "Shut Down"
      t.text    :command
      t.uuid :network_service_id
      t.uuid :pop_id
      t.uuid :user_id

      t.timestamps
    end
  end
end
