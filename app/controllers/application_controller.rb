class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  private

    # Confirms a logged-in user.
    def logged_in_user
      unless logged_in?
        store_location # puts URL in the session variable under the key :forwarding_url only for a GET request
        flash[:danger] = 'Please log in.'
        redirect_to login_url
      end
    end
end
