class Announcement < ApplicationRecord
	include PgSearch #::Model
	pg_search_scope :search, against:
			{
					title: 'A',
					subtitle: 'B',
					body: 'C',
					level: 'D'
			}#, :department, :college, :hall, :program


end
