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

  get     'kyoos/:kyoo_uuid/messages',  to: 'messages#query',          as: 'messages_query'
  post    'kyoos/:kyoo_uuid/messages',  to: 'messages#write',          as: 'messages_write'
  get     'kyoos/:kyoo_uuid/messages/:uuid',  to: 'messages#read',     as: 'messages_read'
  post    'kyoos/:kyoo_uuid/messages/:uuid',  to: 'messages#update',   as: 'messages_update'
  delete  'kyoos/:kyoo_uuid/messages/:uuid',  to: 'messages#destroy',  as: 'messages_destroy'

  get     'policies',        to: 'policies#query',    as: 'policies_query'
  post    'policies',        to: 'policies#write',    as: 'policies_write'
  get     'policies/:uuid',  to: 'policies#read',     as: 'policies_read'
  delete  'policies/:uuid',  to: 'policies#destroy',  as: 'policies_destroy'
end
