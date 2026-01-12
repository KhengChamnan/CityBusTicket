# Base controller for all admin controllers
# All admin controllers inherit from this to share common behavior
class Admin::BaseController < ApplicationController
  # Use admin-specific layout
  layout "admin"

  # Require admin authentication for all admin pages
  before_action :require_admin

  private

  # Check if user is logged in and is an admin
  def require_admin
    # Then check if user is an admin
    unless Current.session.user.admin?
      redirect_to root_path, alert: "You are not authorized to access this section."
    end
  end
end
