# Pin npm packages by running ./bin/importmap

pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
pin "@hotwired/stimulus", to: "stimulus.min.js", preload: true
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js", preload: true
pin_all_from "app/javascript/controllers", under: "controllers"
pin "@github/webauthn-json/browser-ponyfill", to: "https://ga.jspm.io/npm:@github/webauthn-json@2.1.1/dist/esm/webauthn-json.browser-ponyfill.js"
pin "url-safe-base64", to: "https://ga.jspm.io/npm:url-safe-base64@1.3.0/src/index.js"
pin_all_from "app/javascript"
pin "selectlist", to: "https://esm.sh/gh/cjdenio/selectlist-polyfill@ff6dd0f366/src/polyfill.js"
pin "cursor-chat", to: "https://esm.sh/gh/obl-ong/cursor-chat-actioncable@9befe0089b/dist/cursor-chat.es.js"
pin "local-time", to: "https://ga.jspm.io/npm:local-time@3.0.2/app/assets/javascripts/local-time.es2017-esm.js"
pin "@sentry/browser", to: "https://ga.jspm.io/npm:@sentry/browser@7.107.0/esm/index.js"
pin "@sentry-internal/feedback", to: "https://ga.jspm.io/npm:@sentry-internal/feedback@7.107.0/esm/index.js"
pin "@sentry-internal/replay-canvas", to: "https://ga.jspm.io/npm:@sentry-internal/replay-canvas@7.107.0/esm/index.js"
pin "@sentry-internal/tracing", to: "https://ga.jspm.io/npm:@sentry-internal/tracing@7.107.0/esm/index.js"
pin "@sentry/core", to: "https://ga.jspm.io/npm:@sentry/core@7.107.0/esm/index.js"
pin "@sentry/replay", to: "https://ga.jspm.io/npm:@sentry/replay@7.107.0/esm/index.js"
pin "@sentry/utils", to: "https://ga.jspm.io/npm:@sentry/utils@7.107.0/esm/index.js"
