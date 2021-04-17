Rails.application.routes.draw do
  post "user_questions/score/:id", to: "user_questions#save_score", as: :save_score
  get "user_questions/index", to: "user_questions#index", as: :questions
  post "user_questions/send_response", to: "user_questions#store_response", as: :send_response
  get "add/question", to: "users#question", as: :question
  post "add/question", to: "users#add", as: :add_question
  get "users/performance", to: "users#performance", as: :performance
  get "user_questions/summary", to: "user_questions#summary", as: :summary
  post "user_questions/submit", to: "user_questions#submit", as: :submit
  root to: "users#new"
  get "users/login", to: "users#new"
  post "users/login", to: "users#login", as: :user_login
  delete "users/logout/:id", to: "users#destroy", as: :user_logout
  get "/quiz_details", to: "users#quiz_details", as: :quiz_details
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
