BowlingCharts::Application.routes.draw do
  resources :bowling
  post 'bowling/frame', to: 'bowling#frame'
  root 'bowling#index'
end
