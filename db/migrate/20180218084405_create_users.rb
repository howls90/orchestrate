class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users, id: false do |t|
      t.primary_key :id, :uuid, :default => 'uuid_generate_v1()'	
      t.string :name
      t.string :email
      t.string :password_digest
      t.boolean :is_admin, default: false    
      t.timestamps
    end
  end
end
