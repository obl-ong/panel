# Obl.ong

This is the backbone for Obl.ong, a nonprofit service providing free, quality domains for all. You can run this on your infrastructure if you're looking to manage subdomains or an internal TLD.

## Building

- Install Ruby **3.1.2**
- Install Ruby on Rails with Bundler
- Pull submodules
- Run `rails credentials:edit` and add these keys:
  ```
  dnsimple:
    access_token: DNSIMPLE_ACCESS_TOKEN
    account_id: ACCOUNT_ID

  postmark_api_token: "POSTMARK_API_TOKEN"
  ```
- Run `rails tailwindcss:build`
- Edit `config/application.rb` to reflect your environment
- Start the server with `bin/rails server`
