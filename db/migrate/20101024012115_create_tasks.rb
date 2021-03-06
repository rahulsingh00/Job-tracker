class CreateTasks < ActiveRecord::Migration
  def self.up
    create_table :tasks do |t|
      t.string :title
      t.text :description
      t.string :priority
      t.date :start_date
      t.date :end_date
      t.string :complexity

      t.timestamps
    end
  end

  def self.down
    drop_table :tasks
  end
end
