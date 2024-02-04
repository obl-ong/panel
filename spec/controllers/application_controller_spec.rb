require "rails_helper"

RSpec.describe ApplicationController, type: :controller do
  controller do
    def index
      render status: 200, plain: "it rendered"
    end
  end

  describe "site configuration" do
    context "does not exist" do
      it "redirects to new config page" do
        get :index
        pending "Redirection skipped because wizard doesn't exist"
        expect(response).to redirect_to(new_configuration_url)
      end
    end
  end

  context "exists" do
    it "does not redirect" do
      create(:configuration)
      get :index
      expect(response).not_to redirect_to(new_configuration_url)
    end
  end
end
