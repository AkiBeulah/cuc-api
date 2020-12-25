class CourseEnrollment < ActiveRecord::Migration[6.0]
  def change
    create_table :course_enrollment do |t|
      t.belongs_to :course
      t.belongs_to :user

      t.timestamps
    end
  end
end
