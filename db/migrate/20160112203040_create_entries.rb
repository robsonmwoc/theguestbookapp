class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.string :name
      t.string :message

      t.timestamps null: false
    end
  end
end
