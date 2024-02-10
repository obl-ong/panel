
![Obl.ong: Free, quality domains backed by a nonprofit](https://github.com/obl-ong/admin/assets/19589006/2ee94019-99db-499e-8076-7fd52fd28629)

# Admin by Obl.ong

[![produced by human, not by AI](https://github.com/obl-ong/admin/assets/19589006/ac2ac305-2407-469e-8a3b-355b6df19ae9#gh-dark-mode-only)](https://notbyai.fyi#gh-dark-mode-only)

[![produced by human, not by AI](https://github.com/obl-ong/admin/assets/19589006/b4cf0ff8-bd96-4dee-bfd7-0395dfffbc72#gh-light-mode-only)](https://notbyai.fyi#gh-light-mode-only)

An application for multi-tenant domain services (registry, registrar, zone management, and more) built with Ruby on Rails, open source and forever free.

This powers the `obl.ong` domain registry, which provides free, quality domains for all.

Built by Obl.ong, a membership-first nonprofit -- we encourage contributions!

---

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
