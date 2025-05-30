class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  # before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  rescue_from ActionController::RoutingError, with: :route_not_found
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [ :first_name, :last_name, :age, :birthday, :gender ])
  end

  public

  def route_not_found
    respond_to do |format|
      format.html { render 'errors/not_found', status: :not_found }
      format.json { render json: { error: "404 Not Found" }, status: :not_found }
      format.any  { head :not_found }
    end
  end

  def record_not_found
    respond_to do |format|
      format.html do
        flash[:alert] = "Sorry, the record you were looking for doesn't exist."
        redirect_back fallback_location: root_path
      end
      format.json { render json: { error: "Record not found" }, status: :not_found }
    end
  end
end
