module Puppet::Parser::Functions
  newfunction(:hiera_array_undef, :type => :rvalue) do |*args|
    require 'hiera_puppet'
    key, override = HieraPuppet.parse_args(args)
    HieraPuppet.lookup(key, :undef, self, override, :array)
  end
end
