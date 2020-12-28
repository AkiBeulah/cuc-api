class Announcement < ApplicationRecord
	include PgSearch #::Model
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

end
