
![Obl.ong: Free, quality domains backed by a nonprofit](https://github.com/obl-ong/admin/assets/19589006/2ee94019-99db-499e-8076-7fd52fd28629)

# Obl.ong

This is the backbone for Obl.ong, a nonprofit service providing free, quality domains for all. You can run this on your infrastructure if you're looking to manage subdomains or an internal TLD.

## Building

- Install Ruby **3.3.0**
- Install Ruby on Rails with Bundler
- Install Bun for compiling tailwind
- Pull submodules
- Run `rails credentials:edit` and add these keys:
  
  ```
  dnsimple:
    access_token: DNSIMPLE_ACCESS_TOKEN
    account_id: ACCOUNT_ID

  postmark_api_token: "POSTMARK_API_TOKEN"
  sentry: SENTRY_URI
  ```
  
- Run `rails assets:precompile` (if building for prod - DO NOT DO IN DEVELOPMENT)
- Copy `app/javascript/application.js` to `public/assets/application-{hash}.js` (must be done every time assets is recompiled)
- Edit `config/application.rb` to reflect your environment
- Start the server with `bin/rails server`

## Translations

We are working to integrate with [Weblate](https://hosted.weblate.org/projects/oblong/) to allow for translation submissions.
