class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_locale

  protect_from_forgery

  def after_sign_in_path_for(resource)
    user_path(current_user.to_s.downcase)
  end

  def after_sign_up_path_for(resource)
    user_path(resource)
  end

  def default_url_options(options = {})
    { locale: I18n.locale }.merge options
  end

  protected

  def set_locale
    I18n.locale = params[:locale]
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) do |u|
      u.permit(:email,
               :gender,
               :password,
               :password_confirmation,
               :remember_me,
               :username,
               :about_you,
               :cs_user,
               :be_welcome_user,
               :lat,
               :lng,
               :city,
               :location,
               :country,
               :country_code,
               :origin,
               :languages,
               :date_of_birth)
    end
  end
end
