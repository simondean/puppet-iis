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

  def self.extract_complex_properties(item_xml)
    bindings = []

    item_xml.xpath("bindings/binding").each do |binding_xml|
      bindings << "#{binding_xml.attributes["protocol"].value}/#{binding_xml.attributes["bindingInformation"].value}"
    end

    { :bindings => bindings }
  end

  def get_complex_property_arg(name, value)
    case name
      when :bindings
        puts "value: #{value}"
        puts "value.length: #{value.length}"
        value.collect do |binding|
          parts = binding.split('/', 2)
          "/+bindings.[protocol='#{parts[0]}',bindingInformation='#{parts[1]}']"
        end
      else
        nil
    end
  end
end