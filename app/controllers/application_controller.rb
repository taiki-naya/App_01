class ApplicationController < ActionController::Base
  before_action :get_leagues_and_teams
    def get_leagues_and_teams
        @leagues = League.all
    end
  before_action :configure_permitted_parameters, if: :devise_controller?
  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:account_update, keys: [:admin])
  end
end
