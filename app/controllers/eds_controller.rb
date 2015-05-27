# -*- encoding : utf-8 -*-
# require 'blacklight/catalog'

class EdsController < ApplicationController
  layout 'quicksearch'

  #before_filter :authenticate_user!

  #include Blacklight::Catalog

  def index
    # controller, action, and "adv"...
    if params.size == 3
      session.delete(:results)
    end
    # Rails.logger.debug "AAA" + params.inspect
    # render 'index', params: params
  end

  def fulltext_url
    render layout: false
  end

end

