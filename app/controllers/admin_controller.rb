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

    def review
        @domains = Domain.where(provisional: true).map { |d| {domain_id: d.id, host: d.host, plan: d.plan} }
    end

    def review_decision
        domain = Domain.find_by(id: params[:domain_id])

        if params[:provisional_action] == "accept" 
            domain.update(provisional: false)
        elsif params[:provisional_action] == "reject"
            domain.destroy
        end
    end

    private

    def require_admin
        if current_user.admin? != true
          render status: 403, plain: "403 Forbidden"
        end
    end
end
