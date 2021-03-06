Rails.application.routes.draw do
  root to: 'home#show'

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    invitations: 'users/invitations',
    sessions: 'users/sessions',
    confirmations: 'users/confirmations',
    passwords: 'users/passwords'
  }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/dashboard', to: 'dashboard#show'

  resources :users do
    post '/start-crawling', to: 'crawls#crawl_website'
    resources :activities, only: [:index]
    resources :crawls, only: [:show] do
      member do
        get '/export-crawl', to: 'crawls#export_crawl'
      end
    end
  end
end
