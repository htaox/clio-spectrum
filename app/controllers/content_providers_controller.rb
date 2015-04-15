class ContentProvidersController < ApplicationController
  # GET /content_providers
  # GET /content_providers.json

  load_and_authorize_resource :except => [ 'index' ]

  layout 'no_sidebar_no_search'

  def index
    @content_providers = ContentProvider.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @content_providers }
    end
  end

  # GET /content_providers/1
  # GET /content_providers/1.json
  def show
    # @content_provider = ContentProvider.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @content_provider }
    end
  end

  # GET /content_providers/new
  # GET /content_providers/new.json
  def new
    @content_provider = ContentProvider.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @content_provider }
    end
  end

  # GET /content_providers/1/edit
  def edit
    # @content_provider = ContentProvider.find(params[:id])
  end

  # POST /content_providers
  # POST /content_providers.json
  def create
    @content_provider = ContentProvider.new(params[:content_provider])

    respond_to do |format|
      if @content_provider.save
        format.html { redirect_to @content_provider, notice: 'Content provider was successfully created.' }
        format.json { render json: @content_provider, status: :created, location: @content_provider }
      else
        format.html { render action: "new" }
        format.json { render json: @content_provider.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /content_providers/1
  # PUT /content_providers/1.json
  def update
    # @content_provider = ContentProvider.find(params[:id])

    respond_to do |format|
      if @content_provider.update_attributes(params[:content_provider])
        format.html { redirect_to @content_provider, notice: 'Content provider was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @content_provider.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /content_providers/1
  # DELETE /content_providers/1.json
  def destroy
    # @content_provider = ContentProvider.find(params[:id])
    @content_provider.destroy

    respond_to do |format|
      format.html { redirect_to content_providers_url }
      format.json { head :no_content }
    end
  end
end
