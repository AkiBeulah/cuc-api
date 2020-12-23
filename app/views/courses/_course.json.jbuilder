json.extract! course, :id, :course_code, :course_description, :course_unit, :course_unit_temp, :status, :semester, :created_at, :updated_at
json.url course_url(course, format: :json)
