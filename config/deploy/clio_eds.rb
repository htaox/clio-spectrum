
set :rails_env, 'clio_eds'
set :application, 'clio_eds'
set :domain,      'clio-eds.cul.columbia.edu'
set :deploy_to,   "/opt/passenger/clio_test_eds/"
set :user, 'deployer'
set :scm_passphrase, 'Current user can full owner domains.'

role :app, domain
role :web, domain
role :db,  domain, primary: true


