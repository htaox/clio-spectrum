# -*- encoding : utf-8 -*-
# require 'blacklight/catalog'

class EdsController < ApplicationController
  layout 'quicksearch'

  #before_filter :authenticate_user!

  #include Blacklight::Catalog

  def index
    # Rails.logger.debug "AAA" + params.inspect
    # render 'index', params: params
  end

end

