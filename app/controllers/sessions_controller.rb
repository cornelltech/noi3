class SessionsController < Devise::SessionsController
    def create
        self.resource = warden.authenticate(auth_options)
        unless self.resource.nil?
            set_flash_message!(:notice, :signed_in)
            sign_in(resource_name, resource)
            yield resource if block_given?
            respond_with resource, location: after_sign_in_path_for(resource)
        else # error state
            set_flash_message!(:notice, :error)
            respond_to do |format|
                format.js {
                    render :file => "/pages/fetch_log_in.js.erb"
                }
                format.html { respond_with resource, location: "/users/sign_in" }
            end
        end
    end
end