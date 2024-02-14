# Pin npm packages by running ./bin/importmap

pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
pin "@hotwired/stimulus", to: "stimulus.min.js", preload: true
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js", preload: true
pin_all_from "app/javascript/controllers", under: "controllers"
pin "@github/webauthn-json/browser-ponyfill", to: "https://ga.jspm.io/npm:@github/webauthn-json@2.1.1/dist/esm/webauthn-json.browser-ponyfill.js"
pin "url-safe-base64", to: "https://ga.jspm.io/npm:url-safe-base64@1.3.0/src/index.js"
pin_all_from "app/javascript"
pin "selectlist", to: "https://esm.sh/selectlist-polyfill@0.3.0", preload: true
pin "cursor-chat", to: "https://esm.sh/gh/obl-ong/cursor-chat-actioncable@9befe0089b/dist/cursor-chat.es.js"
