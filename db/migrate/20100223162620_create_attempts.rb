class CreateAttempts < ActiveRecord::Migration
  def self.up
    create_table :attempts do |t|
      t.integer :site_id
      t.boolean :success
      t.string :status
      t.timestamps
    end
  end
  
  def self.down
    drop_table :attempts
  end
end
