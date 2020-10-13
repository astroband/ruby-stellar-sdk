require "active_support/core_ext/string/inflections"

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
