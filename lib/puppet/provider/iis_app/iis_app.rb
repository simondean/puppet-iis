require File.join(File.dirname(__FILE__), '../iis/iis_object')

Puppet::Type.type(:iis_app).provide(:iis_app, :parent => Puppet::Provider::IISObject) do
	desc "IIS App"

  confine :operatingsystem => :windows
  defaultfor  :operatingsystem => :windows

  commands :appcmd => File.join(ENV['SystemRoot'] || 'c:/windows', 'system32/inetsrv/appcmd.exe')

  mk_resource_methods

  private
  def self.iis_type
    "app"
  end

  def get_name_args()
    site_name, path = name.split('/', 2)
    path = "/#{path}"
    ["/site.name:#{site_name}", "/path:#{path}"]
  end
end