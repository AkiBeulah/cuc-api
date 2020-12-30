# frozen_string_literal: true

class User < ActiveRecord::Base
	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable and :omniauthable

	extend Devise::Models
	devise :database_authenticatable, :registerable,
				 :recoverable, :rememberable, :trackable, :validatable
	include DeviseTokenAuth::Concerns::User

	has_many :course_enrollments
	has_many :courses, through: :course_enrollments
end
