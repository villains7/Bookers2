Rails.application.routes.draw do
devise_for :users
devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

root to: "homes#top"
  get "home/about" => 'homes#about',as: 'about'


  devise_scope :user do
  post 'users/guest_sign_in',to: 'users/sessions#guest_sign_in'
  end
resources :books,only: [:index,:show,:create,:edit,:update,:destroy]
resources :users, only: [:show,:edit,:update,:index]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
