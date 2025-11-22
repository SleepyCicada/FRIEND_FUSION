Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :topics do
    resources :events, only: :index
  end

  get "/events", to: "events#index", as: :events

  resources :events, only: [:index, :show] do
    resources :confirmations, only: [:create, :destroy]
    # member do
    #   get :conversation_starters
    # end
  end

>>>>>>> master

  get "/events/:id/conversation_starters", to: "events#conversation_starters"

  resources :chats, only: :show do
    resources :messages, only: [:index, :create]
  end

  get"/chats/:id/summary", to: "chats#summary"

  resources :ai_chats, only: :show do
    resources :ai_messages, only: [:index, :create]
  end
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
#   resources :topics do
#   resources :events, only: [:index, :show]
# end

end
