class DomainsController < ApplicationController
  def index
    @domains = Domain.all
  end

  def show
    @domain = Domain.find_by(name: params[:name])
  end

  def new
  end

  def create
    d = Domain.create!(domain_params)
    redirect_to d
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def domain_params
    params.require(:domain).permit(:name)
  end
end
