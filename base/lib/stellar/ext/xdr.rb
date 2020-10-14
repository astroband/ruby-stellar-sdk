require "active_support/core_ext/string/inflections"
require "xdr"

# For every member of XDR::Enum define constant on the corresponding enum type class.
# Constant name is a member name stripped of the common prefix with enum type name.
XDR::DSL::Enum.redefine_method(:seal) do
  names = [members.keys.first, name.demodulize.underscore + "_"].join(" ")
  common_prefix = /\A(.*_).* \1.*\Z/.match(names)&.values_at(1)&.first
  common_prefix_regexp = Regexp.compile("^#{common_prefix}")
  members.each do |name, value|
    const_set(name.sub(common_prefix_regexp, "").upcase, value)
  end
  self.sealed = true
end

# XDR::Union generates an attribute method for each `arm`, but lacks the
# actual `attribute(attr)` method those generated methods delegate to.
# We follow the semantics of the bang variant `XDR::Union#attribute!` method,
# except that calls to `raise` are replaced with early returns of nil.
XDR::Union.define_method(:attribute) do |attr|
  return unless @arm.to_s == attr
  get
end
