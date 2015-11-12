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

        # Persist the results for debugging
        outfile = File.join(Rails.root, "tmp/eds-databases-load.out")
        File.open(outfile, "w") do |f|
          f.write(results)
        end

        # Extract "databases" from the Statistics section
        databases = results['SearchResult']['Statistics']['Databases']
        puts "Database count: #{databases.size}"
        databases.each { |d| d['processed'] = false }

        # Extract "content providers" from the Statistics section
        content_provider_facet = results['SearchResult']['AvailableFacets'].select { |facet|
          facet['Id'] == 'ContentProvider'
        }.first
        content_providers = content_provider_facet['AvailableFacetValues']
          .map { |value|
            value['Value']
          }
        puts "Content Provider count: #{content_providers.size}"

        # database_names = databases.map { |db| db['Label']}
        #       
        # puts "==== databases minus content providers"
        # puts database_names - content_providers
        # 
        # puts "==== content providers minus databases"
        # puts content_providers - database_names

        # We'll want to only keep any EDS Database which is not 
        # available as a Content Provider facet option, 
        # because we can't facet search results by that value
        databases.each { |d|
          puts "Ignoring database [#{d.inspect}] - not found in Content Provider facet" unless content_providers.include?(d['Label'])
        }

        databases.select! { |d|
          content_providers.include?(d['Label'])
        }

        stored_all = ContentProvider.all
        puts "stored count: #{stored_all.size}"

        # EACH CURRENT CONTENT PROVIDER
        # if found in list of databases (string match on name)
        # - IF eds-database-id mismatch, ERROR
        # - fill in blank eds-database-id
        # - mark active = true
        # - mark last-seen = now
        # - mark database as processed
        # else, if string mismatch on name, but eds-database-id is good...
        # - update name/lastseen/active
        # - report
        # else, if NOT found
        # - mark active == false
        # - report

        stored_all.each { |stored|
          # fix badly stored ampersand
          clean_name = stored.name.gsub(/&amp;/, '&')
          # (1) look for match on name...
          match = databases.select{ |d| d['Label'] == clean_name }.first

          if match.present?
            if stored.eds_database_id.present? &&
                stored.eds_database_id != match['Id']
              raise "ERROR: #{stored.eds_database_id} != #{match['Id']}"
            end
            # fill in the values
            if stored.eds_database_id.blank?
              puts "new match on [#{match['Id']}]  #{clean_name}"
              stored.eds_database_id = match['Id']
            end
            stored.name = clean_name
            stored.last_seen = Time.now()
            stored.active = true
            stored.save!
            match['processed'] = true

            next
          end

          # (2) look for match on ID...
          match = databases.select{ |d| d['Id'] == stored.eds_database_id }.first

          if match.present?
            # fill in the values
            # (some EDS databases have no label)
            if stored.name.present? && match['Label'].present?
              puts "name fix for #{match['Id']}: [#{stored.name}] ==> [#{match['Label']}]"
              stored.name = match['Label']
            end
            stored.last_seen = Time.now()
            stored.active = true
            stored.save!
            match['processed'] = true

            next
          end

          # If we dropped down to here, we didn't match by name or ID.
          if stored.active == true
            puts "deactivating [#{stored.name}]"
            stored.active = false
            stored.save!
          end
        }

        puts "Unprocessed EDS Databases"
        puts databases.select{ |d| d['processed'] == false }

        # EACH UN-PROCESSED DATABASE (new option?)
        # - insert new Content Provider - name/id/lastseen/active
        # - report

        # puts "==== databases minus stored_names"
        # puts database_names - stored_names
        # 
        # puts "==== stored_names minus databases "
        # puts stored_names - database_names

      end
    end

  end
