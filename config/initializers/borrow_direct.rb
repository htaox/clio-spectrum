
borrow_direct_config = APP_CONFIG['borrow_direct'] || {}

# REQUIRED: Set your BD api_key
BorrowDirect::Defaults.api_key = borrow_direct_config['api_key'] || ''

# # Or, you likely have a different api key for production and
# # testing/dev, if in Rails this is one way to handle that:
# BorrowDirect::Defaults.api_key = Rails.env.production? ? "production_bd_api" : "dev_bd_api"


# Uses BD Test system by default, if you want to use production system instead
BorrowDirect::Defaults.api_base = case Rails.env.to_s
  # PROD
  when 'clio_prod'
    BorrowDirect::Defaults::PRODUCTION_API_BASE

  # TEST
  when 'clio_test'
    BorrowDirect::Defaults::PRODUCTION_API_BASE

  # DEV
  when 'clio_dev'
    BorrowDirect::Defaults::TEST_API_BASE

  when 'test'
    BorrowDirect::Defaults::TEST_API_BASE

  when 'development'
    BorrowDirect::Defaults::PRODUCTION_API_BASE
    # getting mystery failures against the TEST server
    # BorrowDirect::Defaults::TEST_API_BASE

  else
    nil
end

# Set a default BD LibrarySymbol for your library
BorrowDirect::Defaults.library_symbol = borrow_direct_config['library_symbol'] ||"COLUMBIA"

# If you want to do FindItem requests with a default generic patron
# barcode
BorrowDirect::Defaults.find_item_patron_barcode = "9999999"

# BorrowDirect can take an awful long time to respond sometimes. 
# How long are you willing to wait? (Seconds, default 30)
BorrowDirect::Defaults.timeout = borrow_direct_config['timeout'] || 5
