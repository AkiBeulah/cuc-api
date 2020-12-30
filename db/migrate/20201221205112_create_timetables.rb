class CreateTimetables < ActiveRecord::Migration[6.0]
  def change
    create_table :timetables do |t|
      t.string :course_code
      t.string :building
      t.string :venue
      t.string :day
      t.string :time, limit: 11
      t.string :session
      t.string :level

      t.timestamps
    end
  end
end
