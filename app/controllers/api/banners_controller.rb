class Api::BannersController < Api::BaseController
  # check_authorization
  # load_and_authorize_resource
  # 
  # layout 'angular'

  def index
    render json: Banner.all
  end

  def show
    render json: banner
  end

  def create
    safe_params = {
      created_by: current_user || 'anonymous',
      message: params[:message]
    }
    banner = Banner.create!(safe_params)
    render json: banner
  end

  def update
    banner.update_attributes(safe_params)
    render nothing: true
  end

  def destroy
    banner.destroy
    render nothing: true
  end

  private

  def banner
    @banner ||= Banner.find(params[:id])
  end

end
