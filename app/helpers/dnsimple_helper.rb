module DnsimpleHelper
  @@client = Dnsimple::Client.new(
    base_url: if Rails.env.production? then "https://api.dnsimple.com" else "https://api.sandbox.dnsimple.com" end,
      access_token: Rails.application.credentials.dnsimple.access_token
    )
  def client
    return @@client
  end
end
