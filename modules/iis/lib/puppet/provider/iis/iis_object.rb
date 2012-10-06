require 'rexml/document'

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

  def initialize(*args)
    super

    # Make a duplicate of the properties so we can compare them during a flush
    @initial_properties = @property_hash.dup
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
    execute_flush
    @property_hash.clear
  end

  private
  def self.iis_type
    raise Puppet::DevError, "#{self.class} did not override 'iis_type'"
  end

  def self.list
    command_and_args = [command(:appcmd), 'list', iis_type(), '/xml', '/config:*']
    command_line = command_and_args.flatten.map(&:to_s).join(" ")

    output = execute(command_and_args, :failonfail => false)
    raise Puppet::ExecutionFailure, "Execution of '#{command_line}' failed" if output.nil? or output.length == 0

    extract_items(output)
  end

  def self.extract_items(items_xml)
    items = []

    REXML::Document.new(items_xml).each_element("/appcmd/#{iis_type().upcase}") do |item_xml|
      hash = extract_item(item_xml.elements[1])

      hash[:name] = item_xml.attributes["#{iis_type.upcase}.NAME"]
      hash[:provider] = self.name
      hash[:ensure] = :present
      items << hash
    end

    items
  end

  def self.extract_item(item_xml)
    hash = {}

    item_xml.each_element("descendant-or-self::*") do |element|
      element.attributes.each do |key, attribute|
        key = "#{element.xpath}/#{key}".gsub(/\/appcmd\/[^\/]+\/([^\/]+\/)?/, "").gsub("/", "_").downcase
        hash[key.to_sym] = attribute if resource_type.validproperty? key
      end
    end

    hash.merge! extract_complex_properties(item_xml)

    hash
  end

  def self.extract_complex_properties(item_xml)
    {}
  end

  def execute_create
    appcmd *(['add', self.class.iis_type()] + get_name_args() + get_property_args())
  end

  def get_name_args()
    ["/name:#{resource[:name]}"]
  end

  def execute_delete
    appcmd 'delete', self.class.iis_type(), resource[:name]
  end

  def execute_flush
    if @resource[:ensure] != :absent
      args = get_property_args()
      appcmd *(['set', self.class.iis_type(), resource[:name]] + args) if args.length > 0
    end
  end

  def get_property_args()
    args = []

    self.class.resource_type.validproperties.each do |name|
      if name != :ensure
        value = @resource.should(name)

        if not value.nil? and value != @initial_properties[name]
          arg = get_complex_property_arg(name, value)
          arg = get_simple_property_arg(name, value) if arg.nil?

          unless arg.nil?
            args << arg
            @initial_properties[name] = value
            @property_hash[name] = value
          end
        end
      end
    end

    args.flatten
  end

  def get_complex_property_arg(name, value)
  end

  def get_simple_property_arg(name, value)
    "/#{name.to_s.gsub('_', '.')}:#{value}"
  end
end