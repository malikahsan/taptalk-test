Rails.application.routes.draw do
  devise_for :users, defaults: { format: :json },
             path: 'v1/users',
             path_names: {
               sign_in: 'login',
               sign_out: 'logout',
               registration: 'register'
             },
             controllers: {
               sessions: 'v1/users/sessions',
               registrations: 'v1/users/registrations'
             }

  namespace :v1 do
    resources :daily_activities, only: [:create, :index]
  end
end
