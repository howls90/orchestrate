class CreatePops < ActiveRecord::Migration[5.1]
  def change
    create_table :pops, id: :uuid do |t|
      t.string :name
      t.string :ip
      t.string :instance

      t.timestamps
    end
  end
end
