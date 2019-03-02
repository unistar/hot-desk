class CreateBookings < ActiveRecord::Migration[5.2]
  def change
    create_table :bookings do |t|
      t.references :user, foreign_key: true
      t.references :desk, foreign_key: true
      t.date :begin_date
      t.date :end_date

      t.timestamps
    end
    add_index :bookings, [:user_id, :desk_id]
  end
end
