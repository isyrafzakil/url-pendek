Rails.application.routes.draw do
  resources :urls, only: [:new, :create, :show] do
    collection do
      get :report
    end
  end

  get '/:short_code', to: 'urls#redirect', as: :shortened_url

  root 'urls#new'
end
