require 'spec_helper'

describe ItemAlertsController do
  describe 'Create, Read, Update, Delete...' do
    before(:all) do
      User.delete_all
      @priv_user = FactoryBot.create(:user, uid: 'test_mngr')
      @unpriv_user = FactoryBot.create(:user, uid: 'stranger')
    end

    after(:each) do
      spec_logout
    end

    it 'unpriv user cannot see index' do
      spec_login @unpriv_user

      # cannot see index listing
      get :index
      expect(response).not_to be_successful
      expect(response.status).to be(302)

      # # for unpriv, showing non-existant ID raises exception
      # expect do
      #   get :show_table_row, params: { id: '123' }
      # end.to raise_error(ActiveRecord::RecordNotFound)

      # cannot see individual record
      get :show_table_row, params: { id: '123' }
      expect(response).not_to be_successful
      expect(response.status).to be(302)
    end

    it 'priv user can see index' do
      user = spec_login @priv_user
      get :index
      expect(response).to be_successful
      expect(response).to render_template('index')
    end

    it "excercise 'active' logic" do
      spec_login @priv_user

      item_alert = FactoryBot.build(:item_alert)
      expect(item_alert).to_not be_nil
      expect(item_alert.active?).to eq true

      # Starts in the future - NOT ACTIVE
      item_alert = FactoryBot.build(:item_alert,
                                    start_date: '2050-01-01', end_date: nil)
      expect(item_alert.active?).to eq false

      # Starts in the past - ACTIVE
      item_alert = FactoryBot.build(:item_alert,
                                    start_date: '2000-01-01', end_date: nil)
      expect(item_alert.active?).to eq true

      # Ends in the past - NOT ACTIVE
      item_alert = FactoryBot.build(:item_alert,
                                    start_date: nil, end_date: '2000-01-01')
      expect(item_alert.active?).to eq false

      # Ends in the future - ACTIVE
      item_alert = FactoryBot.build(:item_alert,
                                    start_date: nil, end_date: '2050-01-01')
      expect(item_alert.active?).to eq true

      # No times set - ACTIVE
      item_alert = FactoryBot.build(:item_alert,
                                    start_date: nil, end_date: nil)
      expect(item_alert.active?).to eq true

      # From past to future - ACTIVE
      item_alert = FactoryBot.build(:item_alert,
                                    start_date: '2000-01-01', end_date: '2050-01-01')
      expect(item_alert.active?).to eq true

      # From future to past - NOT ACTIVE
      item_alert = FactoryBot.build(:item_alert,
                                    start_date: '2050-01-01', end_date: '2000-01-01')
      expect(item_alert.active?).to eq false
    end

    it 'priv user gets expected err on get non-existant' do
      spec_login @priv_user

      # for priv, showing non-existant ID raises exception
      expect do
        get :show_table_row, params: { id: '99999' }
      end.to raise_error(ActiveRecord::RecordNotFound)
    end

    it 'priv user gets successful empty response on blank json new' do
      spec_login @priv_user
      # NEW
      # JSON returns nulled-out object
      get :new, format: :json
      expect(response).to be_successful

      # item_alert = JSON.parse(response.body)['item_alert']
      item_alert = JSON.parse(response.body)
      expect(item_alert).not_to be_nil
      expect(item_alert[:id]).to be_nil
      expect(item_alert[:author_id]).to be_nil
      expect(item_alert[:message]).to be_nil
      expect(item_alert[:source]).to be_nil
    end

    it 'priv user gets "new" form on html new' do
      spec_login @priv_user

      # HTML should send you to 'new' screen
      get :new, format: :html
      expect(response).to be_successful
      expect(response).to render_template('new')
    end

    it 'priv user gets expected errors on non-supplied required params' do
      spec_login @priv_user

      # Item Alerts should have author_id, message, source, and item_key.
      # Each of the following should be invalid (unprocessable_entity, 422)
      item_alert_attrs = FactoryBot.attributes_for(:item_alert, author_id: nil)
      post :create, params: { item_alert: item_alert_attrs }, format: :json
      expect(response.status).to be(422)

      item_alert_attrs = FactoryBot.attributes_for(:item_alert, message: nil)
      post :create, params: { item_alert: item_alert_attrs }, format: :json
      expect(response.status).to be(422)

      item_alert_attrs = FactoryBot.attributes_for(:item_alert, source: nil)
      post :create, params: { item_alert: item_alert_attrs }, format: :json
      expect(response.status).to be(422)

      item_alert_attrs = FactoryBot.attributes_for(:item_alert, item_key: nil)
      post :create, params: { item_alert: item_alert_attrs }, format: :json
      expect(response.status).to be(422)
    end

    it 'priv user ...' do
      spec_login @priv_user

      # create an alert, using complete set of attributes, should succeed.
      # In HTML, get a redirect to the show page.
      item_alert_attrs = FactoryBot.attributes_for(:item_alert, author_id: @priv_user.id)
      post :create, params: { item_alert: item_alert_attrs }, format: :html
      expect(response.status).to be(302)

      # In JSON, get a 200.
      item_alert_attrs = FactoryBot.attributes_for(:item_alert, author_id: @priv_user.id)
      post :create, params: { item_alert: item_alert_attrs }, format: :json
      expect(response).to be_successful

      # item_alert = JSON.parse(response.body)['item_alert']
      item_alert = JSON.parse(response.body)

      # fetch it back again, as html table row
      get :show_table_row, params: { id: item_alert['id'] }
      expect(response).to be_successful

      # fetch it back again, as raw
      get :show, params: { id: item_alert['id'] }
      expect(response).to be_successful

      # EDIT - HTML req should load "edit" screen
      get :edit, format: :html, params: { id: item_alert['id'] }
      expect(response).to be_successful
      expect(response).to render_template('edit')

      # new BROKEN attributes, re-post to same ID, attempt an update
      item_alert_attrs = FactoryBot.attributes_for(:item_alert, author_id: @priv_user.id, message: nil)
      put :update, format: :json, params: { id: item_alert['id'], item_alert: item_alert_attrs }
      # expect JSON failure reponse - unprocessable_entity (422)
      expect(response.status).to be(422)

      # new VALID attributes, re-post to same ID, to do an update
      item_alert_attrs = FactoryBot.attributes_for(:item_alert, author_id: @priv_user.id, message: 'New Updated Message')
      put :update, format: :html, params: { id: item_alert['id'], item_alert: item_alert_attrs }
      # success means redirect to show page for this record
      expect(response.status).to be(302)
      expect(response).to redirect_to(item_alert_path(item_alert['id']))

      # finally, delete the alert
      delete :destroy, format: :json, params: { id: item_alert['id'] }
      expect(response).to be_successful

      # it should now be gone
      expect do
        get :show_table_row, params: { id: item_alert['id'] }
      end.to raise_error(ActiveRecord::RecordNotFound)

      logout
    end
  end
end
