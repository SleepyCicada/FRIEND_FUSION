Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :topics do
    resources :events, only: :index
  end

  get "/events", to: "events#index", as: :events
  get "/my_events", to: "events#my_events", as: :my_events


  resources :events do
    get :conversation_starters, on: :member
    post :send_starter, on: :member
    resources :confirmations, only: [:create, :destroy]
    resources :feedbacks
  end

  resources :chats, only: :show do
    get :summary, on: :member
    post :ask_ai, on: :member
    resources :messages, only: [:index, :create] do
      get :smart_replies, on: :collection
    end
  end

  resources :ai_chats do
    resources :ai_messages, only: [:index, :create]
  end

  resources :notifications, only: [:index, :show] do
    post :mark_as_read, on: :member
    post :mark_all_as_read, on: :collection
  end

  resources :organizers, only: [:show]

  get "up" => "rails/health#show", as: :rails_health_check
end
