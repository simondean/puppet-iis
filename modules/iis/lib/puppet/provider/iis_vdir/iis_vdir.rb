require File.join(File.dirname(__FILE__), '../iis/iis_object')

Puppet::Type.type(:iis_vdir).provide(:iis_vdir, :parent => Puppet::Provider::IISObject) do
	desc "IIS Virtual Directory"

  confine :operatingsystem => :windows
  defaultfor  :operatingsystem => :windows

  commands :appcmd => File.join(ENV['SystemRoot'] || 'c:/windows', 'system32/inetsrv/appcmd.exe')

  mk_resource_methods

  private
  def self.iis_type
    "vdir"
  end

  def get_name_args()
    path = @resource[:name][(@resource[:iis_app].chomp('/').length)..-1]
    ["/app.name:#{@resource[:iis_app]}", "/path:#{path}"]
  end

  def get_complex_property_arg(name, value)
    case name
      when :physicalpath
        ["/physicalpath:#{value.gsub('/', '\\')}"]
      else
        nil
    end
  end
end