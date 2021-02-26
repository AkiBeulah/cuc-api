# frozen_string_literal: true
require 'bcrypt'

class User < ActiveRecord::Base

	include BCrypt
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

	# RFUID PIN METHODS
	def set_rfid_pin
		@password ||= Password.new(rfuid_pin)
	end

	def set_rfid_pin(new_password)
		@password = Password.create(new_password)
		self.rfuid_pin = @password
	end

	def schedule
		schedule = []
		self.courses.each do |course|
			course.timetables.each do |item|
				schedule.push(item)
			end
		end

		return schedule
	end

	def updateRFUID(rfuid)
		self.rfuid = rfuid
		self.save!
	end
end
