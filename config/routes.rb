Rails.application.routes.draw do

  devise_for :users,
             path: '',
             path_names: {
               sign_in: 'login',
               sign_out: 'logout',
               registration: 'signup'
             },
             controllers: {
               sessions: 'sessions',
               registrations: 'registrations'
             }

  get     'kyoos',        to: 'kyoos#query',   as: 'kyoos_query'
  post    'kyoos',        to: 'kyoos#write',   as: 'kyoos_write'
  get     'kyoos/:uuid',  to: 'kyoos#read',    as: 'kyoos_read'
  delete  'kyoos/:uuid',  to: 'kyoos#destroy', as: 'kyoos_destroy'

  resources :kyoos, param: :uuid, only: [] do
    scope module: 'kyoos' do
      resource :messages, path: '/messages', only: [] do
        get '/',         to: 'messages#query',   as: 'messages_query'
        post '/',        to: 'messages#write',   as: 'messages_write'
        get '/:uuid',    to: 'messages#read',    as: 'messages_read'
        post '/:uuid',   to: 'messages#update',  as: 'messages_update'
        delete '/:uuid', to: 'messages#destroy', as: 'messages_destroy'
      end

      resource :subscriptions, path: '/subscriptions', only: [] do
        get '/',         to: 'subscriptions#query',
                         as: 'subscriptions_query'

        get '/:uuid',    to: 'subscriptions#read',
                         as: 'subscriptions_read'

        post '/:uuid',   to: 'subscriptions#update',
                         as: 'subscriptions_update'

        delete '/:uuid', to: 'subscriptions#destroy',
                         as: 'subscriptions_destroy'
      end
    end
  end

  get     'policies',        to: 'policies#query',    as: 'policies_query'
  post    'policies',        to: 'policies#write',    as: 'policies_write'
  get     'policies/:uuid',  to: 'policies#read',     as: 'policies_read'
  delete  'policies/:uuid',  to: 'policies#destroy',  as: 'policies_destroy'
end
