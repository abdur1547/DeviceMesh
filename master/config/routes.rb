Rails.application.routes.draw do
  draw :api_v0
  post '/auth/login', to: 'authentication#login'
end
