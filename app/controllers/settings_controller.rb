class SettingsController < ApplicationController
  before_filter :authenticate_user!

  layout 'angular'

  def index

  end

  # def template
  #   render :template => 'templates/' + params[:path], :layout => nil
  # end

end
