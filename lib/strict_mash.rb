# https://github.com/hashie/hashie/issues/60
require "hashie/mash"

class StrictMash < Hashie::Mash
  # Extends Hashie::Mash but raises a KeyError when trying to access a property
  # that doens't exist yet. A naive version of this consists in aliasing `[]` to
  # `fetch` but it makes it impossible to use nice Mash aliases such as `<field>!`,
  # `<field>?`, etc.
  # So instead we override `method_missing` with just a tiny patch inside.
  def method_missing(method_name, *args, &blk)
    return self.[](method_name, &blk) if key?(method_name)
    name, suffix = method_name_and_suffix(method_name)
    # PATCH
    if !key?(name) and !suffix
      raise KeyError, %(key not found: "#{name}")
    end
    # EOF PATCH
    case suffix
    when '='.freeze
      assign_property(name, args.first)
    when '?'.freeze
      !!self[name]
    when '!'.freeze
      initializing_reader(name)
    when '_'.freeze
      underbang_reader(name)
    else
      self[method_name]
    end
  end
end
