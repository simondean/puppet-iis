require File.join(File.dirname(__FILE__), '../iis/iis_object')

Puppet::Type.type(:iis_apppool).provide(:iis_apppool, :parent => Puppet::Provider::IISObject) do
	desc "IIS App Pool"

  confine :operatingsystem => :windows
  defaultfor  :operatingsystem => :windows

  commands :appcmd => File.join(ENV['SystemRoot'] || 'c:/windows', 'system32/inetsrv/appcmd.exe')

  mk_resource_methods

  private
  def self.iis_type
    "apppool"
  end
end