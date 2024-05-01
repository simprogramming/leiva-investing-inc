class ApplicationController < ActionController::Base
  include Pundit::Authorization
  include LocaleHelper  # Add other includes as necessary

  before_action :configure_permitted_parameters, if: :devise_controller?
  after_action :verify_authorized, unless: :devise_controller?
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  protected

  def configure_permitted_parameters
    # Add extra permitted columns to devise for registration
    base_attrs = %i[first_name last_name email role]
    devise_parameter_sanitizer.permit(:sign_up, keys: base_attrs)
  end

  private

  def user_not_authorized
    # Define your user not authorized action
    flash[:alert] = t("not_allowed")
    redirect_to(request.referer || root_path)
  end

  # Automatically includes the namespace in Pundit's policy and policy_scope methods
  def authorize(record, query = nil, policy_class: nil)
    namespaced_record = [namespace, record].compact
    super(namespaced_record, query, policy_class: policy_class)
  end

  def policy_scope(scope, policy_scope_class: nil)
    namespaced_scope = [namespace, scope].compact
    super(namespaced_scope, policy_scope_class: policy_scope_class)
  end

  def policy(record)
    namespaced_record = [namespace, record].compact
    super(namespaced_record)
  end

  # Determine the current namespace
  def namespace
    controller_path.split("/").first.to_sym
  end
end
