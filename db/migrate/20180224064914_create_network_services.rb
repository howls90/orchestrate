class CreateNetworkServices < ActiveRecord::Migration[5.1]
  def change
    create_table :network_services, id: :uuid do |t|
      t.string :name

      t.timestamps
    end
  end
end
