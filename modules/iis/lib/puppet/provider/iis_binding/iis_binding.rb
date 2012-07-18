require_relative '../iis_object'

Puppet::Type.type(:iis_binding).provide :iis_binding, :parent => Puppet::Provider::IISObject do
	desc "IIS Binding"

  confine :operatingsystem => :windows

  commands :appcmd => File.join(ENV['SystemRoot'], 'system32/inetsrv/appcmd.exe')

  mk_resource_methods

  private
  def self.iis_type
    "site"
  end

  def self.parse_items_xml(output)
    xml = Nokogiri::XML(output)

    hashes = []

    xml.xpath("/appcmd/#{iis_type().upcase}/*").each do |resource_xml|
      resource_xml.xpath("bindings/binding").each do |binding_xml|
        hash = {}
        hash[:name] = "#{binding_xml.attributes[:protocol].value}/#{binding_xml.attributes[:bindingInformation].value}"
        hash[:site] = resource_xml.attributes[:name].value
        hash[:provider] = self.name
        hash[:ensure] = :present
        hashes << hash
      end
    end

    hashes
  end

  def execute_create
    appcmd 'set', self.class.iis_type(), resource[:site], "/bindings:#{resource[:name]}"
  end

  def execute_delete
    appcmd 'delete', self.class.iis_type(), resource[:name]
  end

end