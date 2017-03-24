class ConfirmationsController < Devise::ConfirmationsController

  protected

    # # The path used after confirmation.
    # def after_confirmation_path_for(resource_name, resource)
    #   if resource.sign_in_count == 0
    #     session[:new_user] = true
    #   end
    #   if signed_in?(resource_name)
    #     signed_in_root_path(resource)
    #   else
    #     new_session_path(resource_name)
    #   end
    # end

end
