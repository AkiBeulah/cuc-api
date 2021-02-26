class Course < ApplicationRecord
	include PgSearch::Model
	pg_search_scope :search, against: {
			course_code: 'A',
			course_title: 'B',
			semester: 'C',
			prerequisite: 'D'
	}, using: {
			:tsearch => {:prefix => true, :any_word => true, :negation => true},
			:trigram => {}
	}
	#, :course_description, :course_grouping, :course_unit ]

	has_many :users
	has_many :timetables
	has_many :users, through: :course_enrollments

	validates :course_code, presence: true, uniqueness: true
	validates :course_title, presence: true
	validates :course_grouping, presence: true
	validates :course_unit, presence: true
	validates :course_unit_temp, presence: true
	validates :status, presence: true
	validates :semester, presence: true
end
