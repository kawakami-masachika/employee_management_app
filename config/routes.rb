Rails.application.routes.draw do
  root 'tops#index'
  namespace :admin do
    resources :employees, :except => %w(edit update)
  end

  resources :employees, :except => %w(new create destroy)
end
