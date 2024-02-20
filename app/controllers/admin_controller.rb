class AdminController < ApplicationController
  nested_layouts "layouts/application"

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
    @domains = Domain.where(provisional: true).map { |d| {resource_id: d.id, name: d.host, plan: d.plan} }
  end

  def developers_review
    @apps = Doorkeeper::Application.where(provisional: true).map { |d| {resource_id: d.id, name: d.name, plan: d.plan, uri: d.redirect_uri} }
  end

  def review_decision
    domain = Domain.find_by(id: params[:domain_id])

    if params[:provisional_action] == "accept"
      domain.update!(provisional: false)
    elsif params[:provisional_action] == "reject"
      domain.destroy!
    end
  end

  def developers_review_decision
    app = Doorkeeper::Application.find_by(id: params[:application_id])

    if params[:provisional_action] == "accept"
      app.update!(provisional: false)
      Developers::ApplicationMailer.with(email: User::User.find_by(id: app.owner_id).email, app: app.name).app_created_email.deliver_later
    elsif params[:provisional_action] == "reject"
      app.destroy!
    end
  end

  def find_current_auditor
    current_user if current_user.admin?
  end

  private

  def require_admin
    if current_user.admin? != true
      render status: 403, plain: "403 Forbidden"
    end
  end
end
