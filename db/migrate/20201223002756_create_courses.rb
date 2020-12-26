class CreateCourses < ActiveRecord::Migration[6.0]
  def change
    create_table :courses do |t|
      t.string :course_code, limit: 6
      t.string :course_title
      t.text :course_description
      t.string :course_grouping
      t.integer :course_unit
      t.integer :course_unit_temp
      t.string :status
      t.string :semester
      t.string :prerequisite

      t.timestamps
    end
  end
end