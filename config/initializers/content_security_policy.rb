# Be sure to restart your server when you modify this file.

# Define an application-wide content security policy.
# See the Securing Rails Applications Guide for more information:
# https://guides.rubyonrails.org/security.html#content-security-policy-header

Rails.application.configure do
  config.content_security_policy do |policy|
    policy.default_src :self, "https://rebound.postmarkapp.com", "https://esm.sh/v135/selectlist-polyfill@0.3.0/es2022/selectlist-polyfill.mjs", "https://ga.jspm.io/npm:local-time@3.0.2/app/assets/javascripts/local-time.es2017-esm.js", "https://esm.sh/selectlist-polyfill@0.3.0"
    policy.font_src :self, :data
    policy.img_src :self, :data
    policy.object_src :none
    policy.script_src :self, "https://rebound.postmarkapp.com"
    policy.style_src :self, "https://unpkg.com/cursor-chat/dist/style.css"
    policy.style_src_attr :self, "'unsafe-inline'"
    # Specify URI for violation reports
    # policy.report_uri "/csp-violation-report-endpoint"
  end

  # Generate session nonces for permitted importmap, inline scripts, and inline styles.
  config.content_security_policy_nonce_generator = ->(request) { request.session.id.to_s }
  config.content_security_policy_nonce_directives = %w[script-src style-src]

  # Report violations without enforcing the policy.
  config.content_security_policy_report_only = true unless Rails.env.production?
end
