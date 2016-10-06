class RegistrationsController < Devise::RegistrationsController

    # override create method
    def create
        build_resource(sign_up_params)

        resource.save
        yield resource if block_given?
        if resource.persisted?
            if resource.active_for_authentication?
                set_flash_message! :notice, :signed_up
                sign_up(resource_name, resource)
                # respond_with resource, location: '/search' and return
                respond_to do |format|
                    format.js {
                        render :file => "/pages/fetch_sign_up_success.js.erb"
                    }
                end
            else
                set_flash_message! :notice, :signed_up
                set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
                expire_data_after_sign_in!
                # respond_with resource, location: '/search' and return
                # redirect_to action: "index", controller: "users"
                respond_to do |format|
                    format.js {
                        render :file => "/pages/fetch_sign_up_success.js.erb"
                    }
                end
            end
        else
            clean_up_passwords resource
            set_minimum_password_length
            respond_to do |format|
                format.html { redirect_to store_url }
                format.js {
                    render :file => "/pages/fetch_sign_up.js.erb"
                }
            end
        end
    end

    def update
      self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
      prev_unconfirmed_email = resource.unconfirmed_email if resource.respond_to?(:unconfirmed_email)

      resource_updated = update_resource(resource, account_update_params)
      yield resource if block_given?
      if resource_updated
        if is_flashing_format?
          flash_key = update_needs_confirmation?(resource, prev_unconfirmed_email) ?
            :update_needs_confirmation : :updated
          set_flash_message :notice, flash_key
        end
        bypass_sign_in resource, scope: resource_name
        # respond_with resource, location: root_path
        respond_to do |format|
            format.html { redirect_to root_path}
            format.js {
                render :file => "/pages/fetch_update_success.js.erb"
            }
        end
      else
        clean_up_passwords resource
        # respond_with resource
        # Delivers partial with error message
        respond_to do |format|
            format.html { redirect_to store_url }
            format.js {
                render :file => "/pages/fetch_update.js.erb"
            }
        end
      end
    end



    private

    def sign_up_params
        params.require(:user).permit(:first_name, :last_name, :email, :username, :password, :password_confirmation, :avatar)
    end

    def account_update_params
        params.require(:user).permit(:first_name, :last_name, :email, :username, :password, :password_confirmation, :current_password, :avatar)
    end
end