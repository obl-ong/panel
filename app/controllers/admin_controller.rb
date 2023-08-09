class AdminController < ApplicationController
    
    nested_layouts 'layouts/application'

    before_action :require_admin
    
    def index

    end

    def users
        @users = User::User.all
    end

    def users_domains
        @domains = Domain.where(user_users_id: params[:id])
    end

    def domains
        @domains = Domain.all
    end

    private

    def require_admin
        if current_user.admin? != true
          render status: 403, plain: "403 Forbidden"
        end
    end
end
