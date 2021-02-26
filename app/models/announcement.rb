class Announcement < ApplicationRecord
	include PgSearch::Model
	pg_search_scope :search, against:
			{
					title: 'A',
					subtitle: 'B',
					body: 'C',
					level: 'D'
			}, using: {
			:tsearch => {:prefix => true, :any_word => true, :negation => true},
			:trigram => {}
	}
	#, :department, :college, :hall, :program

	scope :b_level, -> (user) { where(level: user.level.to_i).or(where(level: 0)) }
	scope :b_department, -> (user) { where(department: user.department.to_s).or(where(department: "all")) }
	scope :b_college, -> (user) { where(college: user.college.to_s).or(where(college: "all")) }
	scope :b_program, -> (user) { where(program: user.program.to_s).or(where(program: "all")) }
	scope :b_hall, -> (user) { where(hall: user.hall.to_s).or(where(hall: "all")) }
	# scope :b_school, -> (user) { where(school: user.school.to_s).or(where(school: "all")) }
	# scope :b_option, -> (user) { where(option: user.option.to_s).or(where(option: "all")) }

	scope :tailor_announcements, -> (user) {
				b_hall(user)
				.or(b_program(user)
				.or(b_college(user)
				.or(b_department(user)
				.or(b_level(user)))))
	}
end