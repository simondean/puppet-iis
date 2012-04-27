require 'nokogiri'

Puppet::Type.type(:iis_apppool).provide(:iis_apppool) do
	desc "IIS App Pool"
	
	commands :appcmd => File.join(ENV['SystemRoot'], 'system32/inetsrv/appcmd.exe')

  mk_resource_methods

  def self.list(name = nil)
    puts "list"
    if name
      output = appcmd('list', 'apppool', '/xml', '/config:*', "/name:#{name}")
    else
      output = appcmd('list', 'apppool', '/xml', '/config:*')
    end

    xml = Nokogiri::XML(output)

    hashes = xml.xpath("/appcmd/APPPOOL/add").collect do |resource_xml|
      hash = xml_to_hash(resource_xml)
      hash[:provider] = self.name
      hash[:ensure] = :present
      hash
    end

    puts "end list"
    hashes
  end

  def self.instances
    puts "instances"
    hashes = list()

    hashes.each do |hash|
      puts "hash #{hash[:name]}"
    end

    puts "end instances"
    hashes.collect { |hash| new(hash) }
  end

  def self.xml_to_hash(element, hash = {}, prefix = nil)
    element.attributes.each do |attribute_name, attribute_value|
      hash[build_key(prefix, attribute_name).to_sym] = attribute_value
    end

    element.children.each { |child| xml_to_hash(child, hash, build_key(prefix, child.node_name)) }

    hash
  end

  def self.build_key(prefix, sub_key)
    prefix ? prefix + '_' + sub_key.downcase : sub_key.downcase
  end

	#def flush
  #end

  # Match resources to providers where the resource name matches the provider name
  def self.prefetch(resources)
    "prefetch"
    instances().each do |provider|
      "checking provider #{provider.name}"
      resource = resources[provider.name]

      if resource
        puts "found resource"
        resource.provider = provider
      end
    end
  end

  #def create
  #  @property_hash[:ensure] = :present
  #  appcmd 'add', 'apppool', "/name:#{resource[:name]}"
  #end

  #def destroy
  #  @property_hash[:ensure] = :absent
  #  appcmd 'delete', 'apppool', "/name:#{resource[:name]}"
  #end

  #def exists?
  #	output = appcmd('list', 'apppool', '/xml')
  #	xml = Nokogiri::XML(output)
  #	xml.xpath("/appcmd/APPPOOL[@name=\"#{resource[:name]}\"]").count > 0
  #end

  def query
    puts "query"
    hashes = list(@resource[:name])

    if hashes.length == 0
      return nil
    end

    @property_hash.update(hashes[0])
    @property_hash.dup
  end

  def properties
    puts "properties"
    if @property_hash.empty?
      @property_hash = query || {:ensure => :absent}
      @property_hash[:ensure] = :absent if @property_hash.empty?
    end

    @property_hash.dup
  end

  def flush
    puts "flush"
    @property_hash.clear
  end

end