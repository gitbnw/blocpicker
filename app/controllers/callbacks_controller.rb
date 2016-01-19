class CallbacksController < Devise::OmniauthCallbacksController
    
    def github
        @user = User.from_omniauth(request.env["omniauth.auth"])
        raise @user.inspect
        User.from_omniauth(request.env["omniauth.auth"]).skip_confirmation!
        User.from_omniauth(request.env["omniauth.auth"]).save!
        sign_in_and_redirect @user
    end
    
end