require 'nokogiri'

Puppet::Type.type(:iis_apppool).provide(:iis_apppool) do
	desc "IIS App Pool"

  confine :operatingsystem => :windows

  commands :appcmd => File.join(ENV['SystemRoot'], 'system32/inetsrv/appcmd.exe')

  mk_resource_methods

  def self.instances
    list().collect { |hash| new(hash) }
  end

  # Match resources to providers where the resource name matches the provider name
  def self.prefetch(resources)
    instances().each do |provider|
      resource = resources[provider.name]

      if resource
        resource.provider = provider
      end
    end
  end

  def exists?
    output = appcmd("list", "apppool", "/xml")
    xml = Nokogiri::XML(output)
    xml.xpath("/appcmd/APPPOOL[@APPPOOL.NAME='#{resource[:name]}']").length > 0
  end

  def properties
    if @property_hash.empty?
      @property_hash = query || {:ensure => :absent}
      @property_hash[:ensure] = :absent if @property_hash.empty?
    end

    @property_hash.dup
  end

  def flush
    if @resource[:ensure] != :absent
      if exists?
        puts "update"
      else
        appcmd 'add', 'apppool', "/name:#{resource[:name]}"
      end

      @property_hash[:ensure] = :present
    else
      appcmd 'delete', 'apppool', resource[:name]
      @property_hash[:ensure] = :absent
    end
  end

  private
  def self.list(name = nil)
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
    element.attributes.each do |attribute_name, attribute_value|
      hash[build_key(prefix, attribute_name).to_sym] = attribute_value
    end

    element.children.each { |child| parse_item_xml(child, hash, build_key(prefix, child.node_name)) }

    hash
  end

  def self.build_key(prefix, sub_key)
    prefix ? prefix + '_' + sub_key.downcase : sub_key.downcase
  end

  def query
    hash = parse_items_xml(appcmd('list', 'apppool', '/xml', '/config:*', "/name:#{name}"))[0]

    @property_hash.update(hash)
    @property_hash.dup
  end
end