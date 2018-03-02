class CreateScenarios < ActiveRecord::Migration[5.1]
  def change
    create_table :scenarios, id: :uuid do |t|
      t.string :name
      t.text   :description

      t.timestamps
    end
  end
end
