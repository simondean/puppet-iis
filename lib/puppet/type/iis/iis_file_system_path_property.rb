require File.join(File.dirname(__FILE__), 'iis_property')

module Puppet
  class IisFileSystemPathProperty < IisProperty
	munge do |value|
      value.to_s.gsub("/", "\\")
    end

    def validate(value)

    end

    def insync?(is)
      self.is_to_s(is).gsub("/", "\\").casecmp(self.should_to_s(@should).gsub("/", "\\")) == 0
    end
  end
end
