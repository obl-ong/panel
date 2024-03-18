# Contributing to Obl.ong

First of all, thank you for wanting to contribute to Obl.ong! Everyone is welcome to help and encouraged to help.

## 📜 Code of Conduct

Obl.ong is governed by the [Code of Conduct](https://github.com/obl-ong/code-of-conduct). You are expected to follow it. Basically, treat other humans with respect and don't discriminate based on any characteristic. You can report any violation to team@obl.ong, and we will take care of it ASAP.

## 🪳 Bug Reporting

Bug Reports are vital to development. You can report bugs using GitHub issues. However, we need information to help squash the bug. Basically:

- Ensure you are using the latest commit or version of Obl.ong.
- Make sure the issue hasn't already been posted by searching the issues.
- Give information about the bug: OS, OS version, Browser Version (if it occured in the browser), ruby version (`ruby -v`), git commit (`git rev-parse --short HEAD`), screenshot (if needed).

Also, please do **not** submit security issues via GitHub issues. Please send an E-mail to team@obl.ong.

## 💻 Setting up a development environment

1. Install the currently supported version Ruby. You can use a tool like [rbenv](https://github.com/rbenv/rbenv) to install ruby. Check the `.ruby-version` file to find it. Usually, it's the latest version, but it never hurts to check.
2. Install Rails. A lot of times it may come preinstalled. Run `rails -v` to check.
3. Install [bun.sh](https://bun.sh). You can do this by running `curl -fsSL https://bun.sh/install | bash`
4. Pull the submodules. Run `git submodule init && git submodule update`
5. Compile the CSS. Run `rails css:build` to do this.
6. Generate active record encryption keys. Save those keys for step 7.
7. Add all of the API keys and credentials using `rails credentials:edit`
  
   ```yaml
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
     Sentry isn't required, so you don't need to provide a URI. Everything else is though, but you can setup a dnsimple and postmark sandbox for free.
8. Modify `config/application.rb` to fit the development environment. Set `config.sentry` to false if you disabled sentry.
9. Remove config/application.rb from your worktree so you don't push test configuration into the repo. (`git update-index --skip-worktree config/application.rb`)
10. Start the development server using `bin/rails server`.

## 👗 Code Styling & Formatting
We use [Standard Ruby](https://github.com/standardrb/standard) ([VSCode Edition](https://marketplace.visualstudio.com/items?itemName=testdouble.vscode-standard-ruby)) to lint and format code. Please run it on changes you make. It keeps the code human-readable and improves code quality.

## 🌐 Translating Obl.ong
We use [Weblate](https://hosted.weblate.org/projects/oblong/) to translate. You can make an account there and start translating!

## ❓ Questions and Comments
If you need help with anything, we have a [forum](https://forum.obl.ong) to help you with anything and everything in regards to Obl.ong.
