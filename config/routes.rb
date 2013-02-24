Teasers::Application.routes.draw do

  match 'join',   to: 'pages#join'
  match 'signup', to: 'pages#signup'

  resources :newsletters

  # Dynamic root_path
  root to: 'pages#join',   constraints: {subdomain: 'staging'}
  root to: 'pages#join',   constraints: {subdomain: 'join'}
  root to: 'pages#signup', constraints: {subdomain: 'signup'}
end
