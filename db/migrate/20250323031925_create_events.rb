class CreateEvents < ActiveRecord::Migration[7.2]
  def change
    create_table :events do |t|
      t.string :title
      t.datetime :date
      t.text :details

      t.timestamps
    end
  end
end
