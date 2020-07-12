# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(_resource)
    posts_path
  end

  private

  def sign_in_required
    redirect_to posts_path if user_signed_in?
  end

  protected

  def configure_permitted_parameters
    added_attrs = %i[email name password password_confirmation sex birth_date avatar]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
    devise_parameter_sanitizer.permit :sign_in, keys: added_attrs
  end
end
