class ApplicationController < ActionController::API
  before_action :bearer_header
  before_action :check_user_sign_in
  # before_action :authenticate_user!

  rescue_from ActionController::BadRequest, ActionView::Template::Error do |e|
    @errors = e.message
    render 'v1/errors', :formats => [:json], :handlers => [:jbuilder], status: :bad_request
  end

  rescue_from ActiveRecord::RecordInvalid do |e|
    @errors = e.message
    render 'v1/errors', :formats => [:json], :handlers => [:jbuilder], status: :not_found
  end

  def bearer_header
    request.headers['Authorization'] = "Bearer "+request.headers['Authorization'].to_s
  end

  def check_user_sign_in
    unless user_signed_in?
      @errors = "Please login first!"
      render 'v1/errors', :formats => [:json], :handlers => [:jbuilder], status: :unauthorized and return
    end
  end

  # def authorize_request!
  #   if request.headers['Authorization'].blank?
  #     @error_message = [I18n.t('unauthorized')]
  #     render 'v1/errors', :formats => [:json], :handlers => [:jbuilder], status: :unauthorized and return
  #   else
  #     begin
  #       @decoded = JwtCryptor.decode(request.headers['Authorization'])
  #       if @decoded.blank?
  #         @error_message = [I18n.t('jwt.errors.messages.token_invalid')]
  #         render 'v1/errors', :formats => [:json], :handlers => [:jbuilder], status: :unauthorized and return
  #       else
  #         @current_user = User.where(jti: @decoded['jti']).first
  #         @error_message = [I18n.t('jwt.errors.messages.revoke_token')]
  #         render 'v1/errors', :formats => [:json], :handlers => [:jbuilder], status: :unauthorized and return unless @current_user.present?
  #       end
  #     rescue ActiveRecord::RecordNotFound => e
  #       @error_message = [e.message]
  #       render 'v1/errors', :formats => [:json], :handlers => [:jbuilder], status: :unauthorized and return
  #     rescue JWT::DecodeError => e
  #       @error_message = [I18n.t('jwt.errors.messages.invalid_token', custom_value: e.message.downcase)]
  #       render 'v1/errors', :formats => [:json], :handlers => [:jbuilder], status: :unauthorized and return
  #     end
  #   end 
  # end
end
