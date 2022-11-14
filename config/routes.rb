# frozen_string_literal: true

Rails.application.routes.draw do
  
  resources :invoices, only: [:index, :show, :create, :update, :destroy] do
    collection do
      get 'emitter_invoices' => 'invoices#emitter_invoices'
    end
  end

  devise_for :users,
             controllers: {
              sessions: 'users/sessions',
              registrations: 'users/registrations'
            }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
