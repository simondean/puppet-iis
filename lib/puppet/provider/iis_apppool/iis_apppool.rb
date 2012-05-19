require 'nokogiri'

Puppet::Type.type(:iis_apppool).provide(:iis_apppool) do
	desc "IIS App Pool"

  confine :operatingsystem => :windows

  commands :appcmd => File.join(ENV['SystemRoot'], 'system32/inetsrv/appcmd.exe')

  mk_resource_methods

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
        resource.provider = new({ :name => name, :ensure => :absent })
      end
    end
  end

  def exists?
    @property_hash[:ensure] != :absent
  end

  def create
    appcmd 'add', 'apppool', "/name:#{resource[:name]}"
    @property_hash[:ensure] = :present
  end

  def destroy
    appcmd 'delete', 'apppool', resource[:name]
    @property_hash[:ensure] = :absent
  end

  def flush
    if @resource[:ensure] != :absent
    #  if exists?
        args = ['set', 'apppool', resource[:name]]

        self.class.resource_type.validproperties.each do |property|
          if property != :ensure
            value = @property_hash[property]
            args << "/#{property.to_s.gsub('_', '.')}:#{value}" unless value.nil?
          end
        end

        appcmd *args if args.length > 3
      #else
      #  appcmd 'add', 'apppool', "/name:#{resource[:name]}"
      #end

      #@property_hash[:ensure] = :present
    #else
    #  appcmd 'delete', 'apppool', resource[:name]
    #  @property_hash[:ensure] = :absent
    end

    @property_hash.clear
  end

  private
  def self.list
    parse_items_xml(appcmd('list', 'apppool', '/xml', '/config:*'))
  end

  def self.parse_items_xml(output)
    xml = Nokogiri::XML(output)

    xml.xpath("/appcmd/APPPOOL/add").collect do |resource_xml|
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
end