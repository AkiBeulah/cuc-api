Rails.application.routes.draw do
  namespace :api do
    scope :v1 do
      mount_devise_token_auth_for 'User', at: 'auth'
    end

    namespace :v1 do
      resources :timetables
      get '/timetable/filter', to: 'timetables#filter'
      post '/timetable/bulk_create', to: 'timetables#bulk_create'

      resources :announcements
      post '/announcements/bulk_create', to: 'announcements#bulk_create'

      resources :courses
      post '/courses/bulk_create', to: 'courses#bulk_create'

			get '/search/', to: 'base#query'
			post '/student/enroll', to: 'base#student_enroll'

      get '/status/', to: 'base#check_status' 
    end
  end
end
