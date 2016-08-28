class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  layout :layout_by_resource

  # before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  def layout_by_resource
    if signed_in?
      'application'
    else
      'home'
    end
  end

  def after_sign_in_path_for(resource)
    dashboard_path
  end

  def after_sign_out_path_for(resource)
    root_path
  end


  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) do |parameter|
      parameter.permit(:first_name, :last_name, :gender, :email, :password)
    end
  end
end
