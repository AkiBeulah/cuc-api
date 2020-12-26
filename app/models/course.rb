class Course < ApplicationRecord
	include PgSearch::Model
	multisearchable against: [:course_code, :course_title, :course_description, :prerequisite]
end
