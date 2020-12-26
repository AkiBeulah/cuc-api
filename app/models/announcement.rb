class Announcement < ApplicationRecord
	include PgSearch::Model
	multisearchable against: [:title, :subtitle, :body, :level, :department, :college, :hall, :program]
end
