class CreateVnfs < ActiveRecord::Migration[5.1]
  def change
    create_table :vnfs, id: :uuid do |t|
      t.string :name
      t.string :description
      t.integer :cpu
      t.integer :ram
      t.integer :disc
      t.string  :url_server
      t.string  :url_monitoring
      t.string  :url_logging
      t.string  :status
      t.text    :command
      t.belongs_to :network_service, index: true
      t.belongs_to :pop, index: true

      t.timestamps
    end
  end
end
