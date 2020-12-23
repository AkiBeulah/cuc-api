class Timetable < ApplicationRecord
  validates :time, presence: true
  validates :building, presence: true
  validates :course_code, presence: true
  validates :day, presence: true
  validates :venue, presence: true
  validates :session, presence: true
end
