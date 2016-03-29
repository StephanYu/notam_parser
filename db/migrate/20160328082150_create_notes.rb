class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.string :icao_code
      t.string :mon
      t.string :tue
      t.string :wed
      t.string :thu
      t.string :fri
      t.string :sat
      t.string :sun

      t.timestamps null: false
    end
  end
end
