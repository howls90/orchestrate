class CreateRrhs < ActiveRecord::Migration[5.1]
  def change
    create_table :rrhs, id: :uuid do |t|
      t.string :model
      t.string :ip
      t.string :version
      t.float  :latitude
      t.float  :longitude
      t.belongs_to :scenario, index: true

      t.timestamps
    end
  end
end
