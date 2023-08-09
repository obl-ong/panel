module DomainAuthorization
    extend ActiveSupport::Concern
  
    included do
      before_action :authorize_domain
    end
  
    def authorize_domain
        if !(current_domain.user_users_id == current_user.id) && !(current_user.admin?)
            render status: 403, plain: "403 Forbidden"
        end
    end

    def current_domain
        Domain.find_by(host: params['host'])
    end


  end