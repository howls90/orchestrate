class CreateVnfs < ActiveRecord::Migration[5.1]
  def change
    create_table :vnfs, id: :uuid do |t|
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
      t.belongs_to :network_service, index: true
      t.belongs_to :pop, index: true

      t.timestamps
    end
  end
end
