class CreateItems < ActiveRecord::Migration
  def self.up
    create_table :items do |t|
      t.string :name
      t.float :price
      t.integer :stock
      t.text :description
      t.string :image

      t.timestamps
    end
  end

  def self.down
    drop_table :items
  end
end
