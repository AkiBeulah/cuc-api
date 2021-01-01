# frozen_string_literal: true

class User < ActiveRecord::Base
	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable and :omniauthable

	extend Devise::Models
	devise :database_authenticatable, :registerable,
				 :recoverable, :rememberable, :trackable, :validatable
	include DeviseTokenAuth::Concerns::User

	validates :email, presence: true, uniqueness: true, format: {
			with: /([a-z]+.[a-z]+@(stu.cu.edu.ng|covenantuniversity.edu.ng))|([a-z]+@covenantuniversity.edu.ng)/i,
			message: "Please make sure to use your official school email"
	}
	validates :username, presence: true, uniqueness: true, format: {
			with: /(?=.{9,10}$)[0-9][0-9][a-zA-Z][a-zA-Z][0-9]+/i,
			message: "Please use your school assigned matriculation number"
	}

	has_many :course_enrollments
	has_many :courses, through: :course_enrollments
end
