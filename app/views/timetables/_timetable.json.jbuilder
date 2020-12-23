json.extract! timetable, :id, :course_code, :building, :venue, :day, :time, :session, :created_at, :updated_at
json.url timetable_url(timetable, format: :json)
