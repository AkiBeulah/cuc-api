class Timetable < ApplicationRecord
	include PgSearch::Model
	pg_search_scope :search, against:
			{
					course_code: 'A',
					time: 'B',
					venue: 'C',
					building: 'D'
			}

	validates :time, presence: true
	validates :building, presence: true
	validates :course_code, presence: true
	validates :day, presence: true
	validates :venue, presence: true
	validates :session, presence: true
end
