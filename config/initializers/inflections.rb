# Be sure to restart your server when you modify this file.

# Add new inflection rules using the following format. Inflections
# are locale specific, and you may define rules for as many different
# locales as you wish. All of these examples are active by default:
# ActiveSupport::Inflector.inflections(:en) do |inflect|
#   inflect.plural /^(ox)$/i, "\\1en"
#   inflect.singular /^(ox)en/i, "\\1"
#   inflect.irregular "person", "people"
#   inflect.uncountable %w( fish sheep )
# end

# These inflection rules are supported but not enabled by default:
ActiveSupport::Inflector.inflections(:en) do |inflect|
  inflect.acronym "A"
  inflect.acronym "AAAA"
  inflect.acronym "CAA"
  inflect.acronym "CNAME"
  inflect.acronym "HINFO"
  inflect.acronym "MX"
  inflect.acronym "NAPTR"
  inflect.acronym "NS"
  inflect.irregular "NS", "NSes"
  inflect.acronym "NSes"
  inflect.acronym "PTR"
  inflect.acronym "SRV"
  inflect.acronym "SPF"
  inflect.acronym "SSHFP"
  inflect.acronym "TXT"
end
