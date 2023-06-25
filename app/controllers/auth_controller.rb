require 'json'

class AuthController < ApplicationController
  
  before_action :headers
  
  
  def login
    options = WebAuthn::Credential.options_for_get(allow: User::Credential.all.map { |c| c.webauthn_id })
    
    session[:authentication_challenge] = options.challenge
    
    @options = options.as_json
  end
  
  def create_key

    user = User::User.find_by(id: session[:current_user_id])

    if session[:email_verified] != true && user.verified != true
      redirect_to controller: "users", action: "email_verification" and return
    end
    

    @options = WebAuthn::Credential.options_for_create(
      user: { id: user.webauthn_id, name: user.email }
    )
    
    session[:creation_challenge] = @options.challenge
  end
  
  def add_key

    user = User::User.find_by(id: session[:current_user_id])
        
    if session[:email_verified] != true && user.verified != true
      redirect_to controller: "users", action: "email_verification" and return
    end

    webauthn_credential = WebAuthn::Credential.from_create(params)

    begin
      webauthn_credential.verify(session[:creation_challenge])

      credo = User::Credential.create(
        webauthn_id: webauthn_credential.id,
        public_key: webauthn_credential.public_key,
        sign_count: webauthn_credential.sign_count,
        user_users_id: session[:current_user_id]
      )

      credo.save

      if session[:email_verified] && user.verified != true
        user.verified = true
        user.save
      end
        
      session[:authenticated] = true
    
      render json: { authenticated: true }
    rescue WebAuthn::Error => e
      render json: { error: true, message: "An error occurred." }
    end
  end
  
  def verify_key
    webauthn_credential = WebAuthn::Credential.from_get(params)

    stored_credential = User::Credential.find_by(webauthn_id: webauthn_credential.id)
    
    if stored_credential == nil
      render json: { error: true, message: "No account found with that key"} and return
    end

    begin
      webauthn_credential.verify(
        session[:authentication_challenge],
        public_key: stored_credential.public_key,
        sign_count: stored_credential.sign_count
      )

      stored_credential.update!(sign_count: webauthn_credential.sign_count)
      
      session[:authenticated] = true
      session[:current_user_id] = stored_credential.user_users_id 
        
      render json: { authenticated: true }
      
    rescue WebAuthn::SignCountVerificationError => e
      session[:authenticated] = true
      
      render json: { authenticated: true }
    
    rescue WebAuthn::Error => e
      render json: { error: true, message: "An error occurred;" }
    end
  end
  
  def unsupported
  end
  
  private
    def headers
      response.set_header("Access-Control-Allow-Credentials", "true")
    end
    
end