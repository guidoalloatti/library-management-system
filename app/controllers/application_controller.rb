class ApplicationController < ActionController::Base
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
