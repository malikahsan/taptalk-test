# frozen_string_literal: true

class V1::Users::SessionsController < Devise::SessionsController
  prepend_before_action :require_no_authentication, only: [:new, :create]
  prepend_before_action :allow_params_authentication!, only: :create
  skip_before_action :verify_signed_out_user
  skip_before_action :bearer_header, :check_user_sign_in, only: :create
  respond_to :json

  def create
    if params[:email].blank? || params[:password].blank?
      @errors = "Invalid login"
      render 'v1/errors', :formats => [:json], :handlers => [:jbuilder], status: :unauthorized and return
    else
      user = User.select(:id, :email, :first_name, :middle_name, :last_name, :encrypted_password)
      if params[:email].include?('@')
        user = user.find_for_database_authentication(email: params[:email])
      else
        user = user.find_for_database_authentication(username: params[:email])
      end
      @errors = "Account not found"
      render 'v1/errors', :formats => [:json], :handlers => [:jbuilder], status: :unauthorized and return unless user.present?

      if user && user.valid_password?(params[:password])
        user = warden.set_user(user, scope: :user)
        resource = warden.authenticate!(user)
      else
        @errors = "Wrong login"
        render 'v1/errors', :formats => [:json], :handlers => [:jbuilder], status: :unauthorized and return
      end

      if resource.blank?
        @errors = "Access Denied"
        render 'v1/errors', :formats => [:json], :handlers => [:jbuilder], status: :unauthorized and return
      end
      sign_in(resource_name, resource)
      @user = user.as_json(only: [:id, :email]).merge!(fullname: user.fullname, token: current_token)
    end
  end

  def destroy
    warden.logout
  end

  private
  def current_token
    request.env['warden-jwt_auth.token']
  end
end
