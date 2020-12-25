Rails.application.routes.draw do
  namespace :api do
    scope :v1 do
      mount_devise_token_auth_for 'User', at: 'auth'
    end

    namespace :v1 do
      resources :timetables
      get '/timetable/filter', to: 'timetables#filter'
      post '/timetable/bulk_create', to: 'timetable#bulk_create'

      resources :announcements
      post '/announcements/bulk_create', to: 'announcements#bulk_create'

      resources :courses
      post '/courses/bulk_create', to: 'courses#bulk_create'
    end
  end
end
