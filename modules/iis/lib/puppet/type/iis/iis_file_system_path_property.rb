require File.join(File.dirname(__FILE__), 'iis_property')

module Puppet
  class IisFileSystemPathProperty < IisProperty
    def validate(value)
      raise Puppet::Error, "Invalid value for attribute '#{name}', must use back slashes instead of forward slashes" if self.should_to_s(value).include?('/')
    end

    def insync?(is)
      self.is_to_s(is).casecmp(self.should_to_s(@should)) == 0
    end
  end
end