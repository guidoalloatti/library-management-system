class ApplicationController < ActionController::Base
  # skip_before_action :verify_authenticity_token
  # prepend_before_action :require_no_authentication, only: [:cancel]
  # protect_from_forgery with: :null_session

  protected

  def after_sign_in_path_for(resource)
    if resource.is_a?(User) && resource.librarian?
      librarian_dashboard_path
    elsif resource.is_a?(User) && resource.member?
      member_dashboard_path
    else
      super
    end
  end
end
