require "active_support/core_ext/string/inflections"
require "xdr"

# For every member of XDR::Enum define constant on the corresponding enum type class.
# Constant name is a member name stripped of the common prefix with enum type name.
XDR::DSL::Enum.redefine_method(:seal) do
  names = [members.keys.first, name.demodulize.underscore + "_"].join(" ")
  common_prefix = /\A(.*_).* \1.*\Z/.match(names)&.values_at(1)&.first
  members.each do |name, value|
    unless common_prefix.nil?
      full_name, name = [name, name.delete_prefix(common_prefix)]
      singleton_class.alias_method(name, full_name)
    end
    const_set(name.upcase, value)
  end
  self.sealed = true
end

XDR::DSL::Union.redefine_method(:switch) do |switch, arm = nil|
  raise ArgumentError, "`switch_on` not defined yet" if switch_type.nil?

  switch = normalize_switch_declaration(switch)
  self.switches = switches.merge(switch => arm)

  unless arm.nil?
    define_singleton_method(arm) do |*args, **kwargs|
      value_type = arms[arm]
      value = if value_type.valid?(args.first)
        args.first
      elsif value_type.ancestors.include?(XDR::Struct)
        value_type.new(kwargs)
      elsif value_type.ancestors.include?(XDR::Union)
        value_type.new(*args[0..1])
      else
        args.first
      end
      new(switch, value)
    end
  end
end

# XDR::Union generates an attribute method for each `arm`, but lacks the
# actual `attribute(attr)` method those generated methods delegate to.
# We follow the semantics of the bang variant `XDR::Union#attribute!` method,
# except that calls to `raise` are replaced with early returns of nil.
XDR::Union.define_method(:attribute) do |attr|
  return unless @arm.to_s == attr
  get
end
