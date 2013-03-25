class OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def all
  	user = User.from_omniauth(request.env["omniauth.auth"])
  	if user.save
    	flash.notice = "Signed in!"
    	sign_in_and_redirect user
  	else
    	session["devise.user_attributes"] = user.attributes
      flash.notice = "Please confirm your name and email"
    	redirect_to sign_up_path
  	end
  end
  alias_method :linkedin, :all

end