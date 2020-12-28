class Course < ApplicationRecord
	include PgSearch #::Model
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


end
