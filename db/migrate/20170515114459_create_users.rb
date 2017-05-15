class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :pass
      t.timestamp :last_login

      t.timestamps
    end
  end
end
