require_relative '../iis_object'

Puppet::Type.type(:iis_site).provide :iis_site, :parent => Puppet::Provider::IISObject do
	desc "IIS Site"

  confine :operatingsystem => :windows
  
  commands :appcmd => File.join(ENV['SystemRoot'], 'system32/inetsrv/appcmd.exe')

  mk_resource_methods

  private
  def self.iis_type
    "site"
  end
end