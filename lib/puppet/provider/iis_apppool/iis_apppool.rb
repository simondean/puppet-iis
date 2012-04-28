require 'nokogiri'

Puppet::Type.type(:iis_apppool).provide(:iis_apppool) do
	desc "IIS App Pool"
	
	commands :appcmd => File.join(ENV['SystemRoot'], 'system32/inetsrv/appcmd.exe')

  mk_resource_methods

  def self.instances
    puts "instances"
    hashes = list()

    hashes.each do |hash|
      puts "hash #{hash[:name]}"
    end

    puts "end instances"
    providers = hashes.collect { |hash| new(hash) }

    providers.each do |provider|
      puts "provider #{provider.name}"
      puts "ensure: #{provider.ensure}"
      puts "ensure: #{provider.get(:ensure)}"
      #provider.each do |name, value|
      #  puts "#{name}: #{value}"
      #end
    end

    providers
  end

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

  def create
    puts "Create"
    puts "Should #{@resource.should(:ensure)}"
    puts "Is #{get(:ensure)}"

    puts "Properties"
    @property_hash.each { |name, value| puts "#{name}: #{value}" }

    #if @resource.should(:ensure) == @property_hash[:ensure]
    #  return
    #end

    @property_hash[:ensure] = :present
    appcmd 'add', 'apppool', "/name:#{resource[:name]}"
  end

  def destroy
    puts "Destroy"
    puts "Should #{@resource.should(:ensure)}"
    puts "Is #{get(:ensure)}"

    #if @resource.should(:ensure) == get(:ensure)
    #  return
    #end

    @property_hash[:ensure] = :absent
    appcmd 'delete', 'apppool', "/name:#{resource[:name]}"
  end

  def exists?
    properties[:ensure] != :absent
  	#output = appcmd('list', 'apppool', '/xml')
  	#xml = Nokogiri::XML(output)
  	#xml.xpath("/appcmd/APPPOOL[@name=\"#{resource[:name]}\"]").count > 0
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
    puts "resource #{@resource[:ensure]}"
    puts "provider #{@property_hash[:ensure]}"

    if @resource[:ensure] != @property_hash[:ensure]
      if @resource[:ensure] == :present
        puts "create"
        appcmd 'add', 'apppool', "/name:#{resource[:name]}"
        @property_hash[:ensure] = :present
      else
        puts "delete"
        appcmd 'delete', 'apppool', "/name:#{resource[:name]}"
        @property_hash[:ensure] = :absent
      end
    else
      puts "update"
    end
  end

  private
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
    if name
      if hashes.length != 0
        hashes[0]
      else
        nil
      end
    else
      hashes
    end
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

  def query
    puts "query"

    hash = self.class.list(@resource[:name])

    if hash.nil?
      return nil
    end

    @property_hash.update(hash)
    @property_hash.dup
    puts "end query"
  end
end