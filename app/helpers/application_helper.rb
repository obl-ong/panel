module ApplicationHelper
  def style_tag(content_or_options_with_block = nil, html_options = {}, &block)
    content =
      if block_given?
        html_options = content_or_options_with_block if content_or_options_with_block.is_a?(Hash)
        capture(&block)
      else
        content_or_options_with_block
      end

    if html_options[:nonce] == true
      html_options[:nonce] = content_security_policy_nonce
    end

    content_tag("style", content.html_safe, html_options)
  end
end
