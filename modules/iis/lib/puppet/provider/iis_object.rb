require 'nokogiri'

class Puppet::Provider::IISObject < Puppet::Provider
  def self.instances
    list().collect do |hash|
      hash[:ensure] = :present
      new(hash)
    end
  end

  # Match resources to providers where the resource name matches the provider name
  def self.prefetch(resources)
    providers = Hash[instances().map { |provider| [provider.name, provider] }]

    resources.each do |name, resource|
      provider = providers[name]

      if provider
        resource.provider = provider
      else
        resource.provider = new(:ensure => :absent)
      end
    end
  end

  def exists?
    @property_hash[:ensure] != :absent
  end

  def create
    execute_create
    @property_hash[:ensure] = :present
  end

  def destroy
    execute_delete
    @property_hash[:ensure] = :absent
  end

  def flush
    if @resource[:ensure] != :absent
      args = ['set', self.class.iis_type(), resource[:name]]

      self.class.resource_type.validproperties.each do |property|
        if property != :ensure
          value = @property_hash[property]

          unless @resource[property].nil? or value.nil?
            value = "\"#{value.gsub('"', '\\"')}\"" if value.include?(' ') || value.include?('"')
            args << "/#{property.to_s.gsub('_', '.')}:#{value}"
          end
        end
      end

      appcmd *args if args.length > 3
    end

    @property_hash.clear
  end

  private
  def self.iis_type
    raise Puppet::DevError, "#{self.class} did not override 'iis_type'"
  end

  def self.list
    parse_items_xml(appcmd('list', iis_type(), '/xml', '/config:*'))
  end

  def self.parse_items_xml(output)
    xml = Nokogiri::XML(output)

    xml.xpath("/appcmd/#{iis_type().upcase}/*").collect do |resource_xml|
      hash = parse_item_xml(resource_xml)
      hash[:provider] = self.name
      hash[:ensure] = :present
      hash
    end
  end

  def self.parse_item_xml(element, hash = {}, prefix = nil)
    element.attributes.each do |attribute_name, attribute|
      hash[build_key(prefix, attribute_name).to_sym] = attribute.value
    end

    element.children.each { |child| parse_item_xml(child, hash, build_key(prefix, child.node_name)) }

    hash
  end

  def self.build_key(prefix, sub_key)
    prefix ? prefix + '_' + sub_key.downcase : sub_key.downcase
  end

  def execute_create
    args = ['add', self.class.iis_type(), "/name:#{resource[:name]}"]

    self.class.resource_type.validproperties.each do |property|
      if property != :ensure
        value = resource.should(property)
        args << "/#{property.to_s.gsub('_', '.')}:#{value}" unless value.nil?
      end
    end

    appcmd *args
  end

  def execute_delete
    appcmd 'delete', self.class.iis_type(), resource[:name]
  end
end