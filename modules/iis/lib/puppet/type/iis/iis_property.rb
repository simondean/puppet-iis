module Puppet
  class IisProperty < Puppet::Property
    munge do |value|
      value.to_s
    end
  end
end
