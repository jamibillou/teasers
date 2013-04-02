Teasers::Application.routes.draw do

  match 'join',   to: 'pages#join'
  match 'signup', to: 'pages#signup'
  match 'resume', to: 'pages#resume'
  match 'templates', to: 'pages#templates'

  resources :newsletters

  # Dynamic root_path

  root to: 'pages#join',   constraints: {subdomain: 'staging'}
  root to: 'pages#join',   constraints: {subdomain: 'join'}
  root to: 'pages#signup', constraints: {subdomain: 'signup'}
  root to: 'pages#resume', constraints: {subdomain: 'resume'}
end
