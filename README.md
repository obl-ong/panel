
![Obl.ong: Free, quality domains backed by a nonprofit](https://github.com/obl-ong/admin/assets/19589006/2ee94019-99db-499e-8076-7fd52fd28629)

# Admin by Obl.ong


[![produced by human, not by AI](https://github.com/obl-ong/admin/assets/19589006/470f71c5-7338-43ae-b42b-b386ad69468c#gh-dark-mode-only)](https://notbyai.fyi#gh-dark-mode-only)

[![produced by human, not by AI](https://github.com/obl-ong/admin/assets/19589006/933d3b3d-9f80-47df-9e4b-57b1055b0c10#gh-light-mode-only)](https://notbyai.fyi#gh-light-mode-only)

An application for multi-tenant domain services (registry, registrar, zone management, and more) built with Ruby on Rails, open source and forever free.

This powers the `obl.ong` domain registry, which provides free, quality domains for all.

Built by Obl.ong, a membership-first nonprofit -- we encourage contributions!


## Building

- Install Ruby **3.3.0**
- Install Ruby on Rails with Bundler
- Install [Bun](https://bun.sh) for compiling tailwind (`curl -fsSL https://bun.sh/install | bash`)
- Pull submodules (`git submoudle init && git submodule update`)
- Compile tailwind (`rails css:build`)
- Generate active record encryption keys (`bin/rails db:encryption:init`)
- Run `rails credentials:edit` and add these keys:
  
  ```
  dnsimple:
    access_token: DNSIMPLE_ACCESS_TOKEN
    account_id: ACCOUNT_ID

  postmark_api_token: "POSTMARK_API_TOKEN"
  sentry: SENTRY_URI
  active_record_encryption:
    primary_key: PRIMARY_KEY
    deterministic_key: DETERMINISTIC_KEY
    key_derivation_salt: KEY_DERIVATION_SALT
  ```
  Note: Sentry isn't required.
- If you are building for production, run `rails assets:precompile`. Don't do this in development.
- Copy `app/javascript/application.js` to `public/assets/application-{hash}.js` (must be done every time assets is recompiled)
- Edit `config/application.rb` to reflect your environment. If you didn't provide a Sentry URI, please set `config.sentry` to false.
- Start the server with `bin/rails server`

## Translations

We are working to integrate with [Weblate](https://hosted.weblate.org/projects/oblong/) to allow for translation submissions.

## Screenshots

![Domains index showing 3 domains](https://github.com/obl-ong/admin/assets/19589006/227d0a2e-70a2-4227-befc-7d3ce6fdc1bb)

![DNS page for fionaho.obl.ong showing 2 records, an A record to 1.1.1.1, and a CNAME at demo to example.com](https://github.com/obl-ong/admin/assets/19589006/b3cd0329-9380-4758-b5e6-22afc7601333)
