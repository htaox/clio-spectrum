class QuickSetController < ApplicationController
  # Devise protection...
  before_filter :authenticate_user!, only: [:new, :edit, :update, :destroy]
  load_and_authorize_resource :only => [:new, :edit, :update, :destroy]

  layout 'no_sidebar_no_search'

  # QUICK SET MANAGEMENT - DEFINING QUICKSETS

  def index
    @quicksets = QuickSet.all
  end

  def show
    @quickset = QuickSet.find(params[:id])
  end

  def new
    @quickset = QuickSet.new
  end

  def edit
    @quickset = QuickSet.find(params[:id])
  end

  def create
    @quickset = QuickSet.new(article_params)

    if @quickset.save
      redirect_to @quickset
    else
      render 'new'
    end
  end

  def update
    @quickset = QuickSet.find(params[:id])

    if @quickset.update_attributes(params['quick_set'])
      redirect_to quick_set_index_path
      # redirect_to @quickset
    else
      render 'edit'
    end
  end

  def destroy
    @quickset = QuickSet.find(params[:id])
    @quickset.destroy

    redirect_to articles_path
  end

  # QUICKSET SEARCHING - PATRON USE OF QUICK SETS

  # build simple query form
  def simple
    @quicksets = QuickSet.where(suppressed: false)
  end

  # build advanced query form
  def advanced
    @quicksets = QuickSet.where(suppressed: false)
  end

  # display the results, based on submitted search params
  def results
    # Search term?
    if ['q', 'q1', 'q2', 'q3'].none? {|key| params[key].present? && params[key].length > 0}
      flash[:error] = "Search term missing"
      return redirect_to scoped_simple_path
    end
    # unless params[:q].present? && params[:q].length > 0
    #   flash[:error] = "Search term missing"
    #   return redirect_to scoped_simple_path
    # end
    # Against which Content Providers?
    unless quickset_id = params.delete(:id)
      flash[:error] = "Must select a QuickSet"
      return redirect_to scoped_simple_path
    end
    @quickset = QuickSet.find(quickset_id)
    @content_providers = @quickset.content_providers
    @escaped_names = @content_providers.collect do |provider|
      # backslash-escape colons, commas, and parens.
      "ContentProvider:" +
        # provider.name.
        #   gsub(':', '%3A').
        #   gsub(',', '%23').
        #   gsub('(', '%28').
        #   gsub(')', '%29')
        # 
          provider.name.gsub(':', '\:').
                        # gsub('(', '\(').
                        # gsub(')', '\)').
                        gsub('&amp;', '&').
                        gsub(',', '\,')
      #  gsub('%28','(').gsub('%3A',':').gsub('%29',')').gsub('%23',',')

    end
# raise
    facetfilter = '1,' + @escaped_names.join(',')

    # OK, now preform the search....
    # ...by redirecting to a full-CLIO-interface EDS search...
    # redirect_to eds_index_path(q: @q, facetfilter: facetfilter, params)
    redirect_to eds_index_path(params.merge(facetfilter: facetfilter))
  end

end


