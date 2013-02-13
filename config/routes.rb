require File.expand_path('../../lib/routes_constraints', __FILE__)

Teasers::Application.routes.draw do

  match 'join',   to: 'pages#join'
  match 'signup', to: 'pages#signup'

  # Dynamic root_path
  root to: 'pages#join',   constraints: Signup.new(false)
  root to: 'pages#signup', constraints: Signup.new(true) 
end
