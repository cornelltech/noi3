# require 'single_sign_on'
require "#{Rails.root}/lib/single_sign_on" 

class DiscourseSsoController < ApplicationController
  before_action :authenticate_user! # ensures user must login

  def sso        
    sso = SingleSignOn.parse(request.query_string, DISCOURSE_CONFIG[:sso_secret])
    sso.email = current_user.email # from devise
    sso.name = "#{current_user.first_name} #{current_user.last_name}"  # this is a custom method on the User class
    sso.username = current_user.username # from devise
    sso.external_id = current_user.id # from devise
    sso.avatar_url = current_user.avatar_url
    # sso.custom_fields["avatar_url"] = current_user.avatar_url
    sso.sso_secret = DISCOURSE_CONFIG[:sso_secret]

    redirect_to sso.to_url(DISCOURSE_CONFIG[:sso_redirect_url])
  end
end