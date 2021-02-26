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

			get '/search', to: 'base#query'
			get '/search/courses', to: 'base#search_courses'
			get '/student/payment_confirmation', to: 'user#payment_confirmation'
			post '/student/enroll', to: 'base#student_enroll'
			post '/student/register_rfuid', to: 'user#register_rfuid'
			post '/student/create_transaction', to: 'user#funding_transaction'
			post '/student/payment_transaction', to: 'user#payment_transaction'
			get '/student/get_balance', to: 'user#get_balance'
			patch '/student/toggle_card_enabled', to: 'user#toggle_card'

			get '/student/schedule', to: 'base#get_schedule'
			get '/student/announcements', to: 'user#tailor_announcements'

      get '/status/', to: 'base#check_status'
    end
  end
end
