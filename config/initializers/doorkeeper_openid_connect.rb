# frozen_string_literal: true

Doorkeeper::OpenidConnect.configure do
  issuer do |resource_owner, application|
    "https://admin.obl.ong"
  end

  signing_key Rails.application.credentials.oidc_key

  subject_types_supported [:pairwise]

  subject do |resource_owner, application|
    Digest::SHA256.hexdigest("#{resource_owner.id}#{URI.parse(application.redirect_uri).host}#{Rails.application.credentials.oidc_salt}")
  end

  resource_owner_from_access_token do |access_token|
    User::User.find_by(id: access_token.resource_owner_id)
  end

  auth_time_from_resource_owner do |resource_owner|
    # Example implementation:
    # resource_owner.current_sign_in_at
  end

  reauthenticate_resource_owner do |resource_owner, return_to|
    # Example implementation:
    # store_location_for resource_owner, return_to
    # sign_out resource_owner
    session[:authenticated] = false
    session[:current_user_id] = nil
    @_current_user = nil
    session[:return_path] = return_to
    redirect_to "/auth/login"
  end

  # Depending on your configuration, a DoubleRenderError could be raised
  # if render/redirect_to is called at some point before this callback is executed.
  # To avoid the DoubleRenderError, you could add these two lines at the beginning
  #  of this callback: (Reference: https://github.com/rails/rails/issues/25106)
  #   self.response_body = nil
  #   @_response_body = nil
  select_account_for_resource_owner do |resource_owner, return_to|
    # Example implementation:
    # store_location_for resource_owner, return_to
    # redirect_to account_select_url
  end

  subject do |resource_owner, application|
    # Example implementation:
    resource_owner.id

    # or if you need pairwise subject identifier, implement like below:
    # Digest::SHA256.hexdigest("#{resource_owner.id}#{URI.parse(application.redirect_uri).host}#{'your_secret_salt'}")
  end

  # Protocol to use when generating URIs for the discovery endpoint,
  # for example if you also use HTTPS in development
  # protocol do
  #   :https
  # end

  # Expiration time on or after which the ID Token MUST NOT be accepted for processing. (default 120 seconds).
  # expiration 600

  # Example claims:
  # claims do
  #   normal_claim :_foo_ do |resource_owner|
  #     resource_owner.foo
  #   end

  #   normal_claim :_bar_ do |resource_owner|
  #     resource_owner.bar
  #   end
  #

  claims do
    claim :name, scope: :name do |resource_owner|
      resource_owner.name
    end

    claim :email, scope: :email do |resource_owner|
      resource_owner.email
    end

    claim :email_verified, scope: :email do |resource_owner|
      resource_owner.verified
    end

    claim :verified, scope: :user do |resource_owner|
      resource_owner.verified
    end

    claim :created_at, scope: :user do |resource_owner|
      resource_owner.created_at
    end

    claim :updated_at, scope: :user do |resource_owner|
      resource_owner.updated_at
    end
  end
end
