require 'nokogiri'

Puppet::Type.type(:iis_apppool).provide(:iis_apppool) do
	desc "IIS App Pool"
	
	commands :appcmd => File.join(ENV['SystemRoot'], 'system32/inetsrv/appcmd.exe')
	
	def create
    @property_hash[:ensure] = :present
    appcmd 'add', 'apppool', "/name:#{resource[:name]}"
	end
	
	def destroy
    @property_hash[:ensure] = :absent
		appcmd 'delete', 'apppool', "/name:#{resource[:name]}"
	end
	
	def exists?
		output = appcmd('list', 'apppool', '/xml')
		xml = Nokogiri::XML(output)
		xml.xpath("/appcmd/APPPOOL[@name=\"#{resource[:name]}\"]").count > 0
	end
  
  def self.instances
  end
  
  def self.prefetch(resources)
    resources.each do |name, resource|
      if result = manager.find(name)
        result[:ensure] = :present
        resource.provider = new(result)
      else
        resource.provider = new(:ensure => :absent)
      end
    end
  end

	def flush
  end

end