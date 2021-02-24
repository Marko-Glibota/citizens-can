class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    # For additional fields in app/views/devise/registrations/new.html.erb
    attrs = [:first_name, :last_name, :zip]

    devise_parameter_sanitizer.permit(:sign_up, keys: attrs)
  end
end
