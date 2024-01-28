class AllowNullRedirectUriForOauth < ActiveRecord::Migration[7.1]
  def change
    change_column_null :oauth_applications, :redirect_uri, true
  end
end
