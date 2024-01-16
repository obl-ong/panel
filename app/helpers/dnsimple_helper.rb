module DnsimpleHelper
  @@client = Dnsimple::Client.new(
    base_url: Rails.env.production? ? "https://api.dnsimple.com" : "https://api.sandbox.dnsimple.com",
    access_token: Rails.application.credentials.dnsimple.access_token
  )
  def client
    @@client
  end
end
