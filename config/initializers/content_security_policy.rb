# Be sure to restart your server when you modify this file.

# Define an application-wide content security policy.
# See the Securing Rails Applications Guide for more information:
# https://guides.rubyonrails.org/security.html#content-security-policy-header

Rails.application.configure do
  config.content_security_policy do |policy|
    policy.default_src :none 
    policy.connect_src :self, "https://rebound.postmarkapp.com/check", "https://*.sentry.io/"
    policy.font_src :self, :data
    policy.img_src :self, :data
    policy.object_src :none
    policy.script_src :self, "'strict-dynamic'", "https://code.ionicframework.com", "https://cdn.jsdelivr.net/npm/toastify-js", "https://ga.jspm.io/npm:@sentry/", "https://ga.jspm.io/npm:@sentry-internal/", "https://rebound.postmarkapp.com/", "https://esm.sh/v135/selectlist-polyfill@0.3.0/", "https://ga.jspm.io/npm:local-time@3.0.2/", "https://esm.sh/selectlist-polyfill@0.3.0/"
    policy.style_src :self, "https://unpkg.com/cursor-chat/dist/style.css", "https://code.ionicframework.com", "https://cdn.jsdelivr.net/npm/toastify-js/src/toastify.min.css"
    policy.style_src_attr :self, "'unsafe-inline'"
    policy.script_src_attr :self, "'unsafe-inline'"
    policy.frame_ancestors :self
    policy.base_uri :self
    policy.form_action :self
    policy.worker_src :self, "blob:"
    policy.child_src :self, "blob:"
    # Specify URI for violation reports
    # policy.report_uri "/csp-violation-report-endpoint"
  end

  # Generate session nonces for permitted importmap, inline scripts, and inline styles.
  config.content_security_policy_nonce_generator = ->(request) { request.session.id.to_s }
  config.content_security_policy_nonce_directives = %w[script-src style-src]

  # Report violations without enforcing the policy.
  config.content_security_policy_report_only = true unless Rails.env.production?
end
