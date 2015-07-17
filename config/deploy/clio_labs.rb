
set :rails_env, 'clio_labs'
set :application, 'clio_labs'
# n.b., hostname has no dash or underscore.
set :domain,      'cliolabs.cul.columbia.edu'
set :deploy_to,   "/opt/passenger/clio_workshop/"
set :user, 'deployer'
set :scm_passphrase, 'Current user can full owner domains.'

role :app, domain
role :web, domain
role :db,  domain, primary: true


