class Api::V1::UserController < Api::V1::ApiController
  before_action do
    doorkeeper_authorize! :user
  end

  def show
    if doorkeeper_token.scopes.exists?(:name)
      @name = current_user.name
    end

    if doorkeeper_token.scopes.exists?(:email)
      @email = current_user.email
    end

    @id = current_user.id
    @created_at = current_user.created_at
    @updated_at = current_user.updated_at
    @verified = current_user.verified

    if doorkeeper_token.scopes.exists?(:admin)
      @admin = current_user.admin
    end
  end

  def update
    redirected = false

    if params[:name]
      if doorkeeper_authorize! :name_write
        redirected = true
      else
        current_user.update!(name: params[:name])
      end
    end

    if params[:email]
      if doorkeeper_authorize! :email_write
        redirected = true
      else
        current_user.update!(email: params[:email])
      end
    end

    if !redirected
      show
      render "show"
    end
  end
end
