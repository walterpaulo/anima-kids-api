class CreateUsuarios < ActiveRecord::Migration[7.0]
  def change
    create_table :usuarios do |t|
      t.string :name
      t.string :email
      t.string :type
      t.string :password

      t.timestamps
    end
  end
end
