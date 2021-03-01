class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    # For additional fields in app/views/devise/registrations/new.html.erb
    attrs = [:first_name, :last_name, :address, :zip, :age, :city, :email]

    devise_parameter_sanitizer.permit(:sign_up, keys: attrs)
  end

  def default_url_options
  { host: ENV["www.citizens-can.com"] || "localhost:3000" }
end
end
