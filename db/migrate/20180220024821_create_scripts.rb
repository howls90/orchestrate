class CreateScripts < ActiveRecord::Migration[5.1]
  def change
    create_table :scripts, id: :uuid do |t|
      t.string :name
      t.string :provider
      t.text   :configuration
      t.belongs_to :vnf, index: true

      t.timestamps
    end
  end
end
