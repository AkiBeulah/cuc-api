class CreateCourses < ActiveRecord::Migration[6.0]
  def change
    create_table :courses do |t|
      t.string :course_code, limit: 6
      t.string :course_description
      t.integer :course_unit
      t.integer :course_unit_temp
      t.char :status
      t.string :semester

      t.timestamps
    end
  end
end
