module Puppet::Parser::Functions
  newfunction(:hiera_array_undef, :type => :rvalue) do |*args|
    require 'hiera_undef'
    key, override = HieraPuppet.parse_args(args)
    HieraPuppet.lookup(key, :undef, self, override, :array)
  end
end
