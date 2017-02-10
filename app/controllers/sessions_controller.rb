class SessionsController < Devise::SessionsController
    # def create
    #     self.resource = warden.authenticate(auth_options)
    #     unless self.resource.nil?
    #         set_flash_message!(:notice, :signed_in)
    #         sign_in(resource_name, resource)
    #         yield resource if block_given?
    #         # respond_with resource, location: after_sign_in_path_for(resource)
    #         respond_to do |format|
    #             format.js {
    #                 render :file => "/pages/fetch_log_in_success.js.erb"
    #             }
    #             format.html { respond_with resource, location: "/"  }
    #         end
    #     else # error state
    #         set_flash_message(:notice, :error)
    #         self.resource = User.new
    #         # self.resource = warden.authenticate(auth_options)
    #         respond_to do |format|
    #             format.js {
    #                 render :file => "/pages/fetch_log_in.js.erb"
    #             }
    #             format.html { respond_with resource, location: "/users/sign_in" }
    #         end
    #     end
    # end

    def destroy
      begin
        discourse_client = DiscourseApi::Client.new(DISCOURSE_CONFIG[:url])
        discourse_client.api_key = DISCOURSE_CONFIG[:api_key]
        discourse_client.api_username = DISCOURSE_CONFIG[:api_username]
        puts current_user.email
        user = discourse_client.user(current_user.username)
        discourse_client.log_out(user["id"]) if user
      ensure
        super      
      end
    end
end