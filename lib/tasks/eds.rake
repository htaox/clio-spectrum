require "#{Rails.root}/app/helpers/blacklight/eds_helper_behavior"
include Blacklight::EdsHelperBehavior

namespace :eds do

  namespace :databases do
      desc("Load Content Providers from EDS")
      task :load => :environment do

        conn = EDSApi::ConnectionHandler.new(2)
        puts "Built connection=#{conn}"

        File.open(auth_file_location, "r") { |f|
          @api_userid = f.readline.strip
          @api_password = f.readline.strip
          @api_profile = f.readline.strip
        }
        conn.uid_init(@api_userid, @api_password, @api_profile, 'n')
        conn.uid_authenticate(:json)
        auth_token = conn.show_auth_token
        puts "Got auth_token=#{auth_token}"

        session_key = conn.create_session(auth_token, 'n')
        puts "Created session_key=#{session_key}"

        apiquery = generate_api_query( {'q' => "FT Y OR FT N", 'resultsperpage' => 0} )
        puts "Submitting apiquery=#{apiquery.inspect}"

        results = conn.search(apiquery, session_key, auth_token, :json).to_hash

        databases = results['SearchResult']['Statistics']['Databases']
        puts "Databases via Statistics: #{databases.size}"

        content_provider_facet = results['SearchResult']['AvailableFacets'].select { |facet|
          facet['Id'] == 'ContentProvider'
        }.first
        content_providers = content_provider_facet['AvailableFacetValues']
          .map { |value|
            value['Value']
          }
        puts "Content Providers via facet: #{content_providers.size}"

        database_names = databases.map { |db| db['Label']}

        puts "==== databases minus content providers"
        puts database_names - content_providers

        puts "==== content providers minus databases"
        puts content_providers - database_names

        stored_names = ContentProvider.all.map { |row| row.name }
        puts "stored_names: #{stored_names.size}"

        puts "==== databases minus stored_names"
        puts database_names - stored_names

        puts "==== stored_names minus databases "
        puts stored_names - database_names

      end
    end

  end
