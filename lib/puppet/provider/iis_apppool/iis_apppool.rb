require 'nokogiri'

Puppet::Type.type(:iis_apppool).provide(:iis_apppool) do
	desc "IIS App Pool"
	
	commands :appcmd => File.join(ENV['SystemRoot'], 'system32/inetsrv/appcmd.exe')
	
	def create
		appcmd 'add', 'apppool', "/name:#{resource[:name]}"
	end
	
	def destroy
		appcmd 'delete', 'apppool', "/name:#{resource[:name]}"
	end
	
	def exists?
		output = appcmd('list', 'apppool', '/xml')
		xml = Nokogiri::XML(output)
		xml.xpath("/appcmd/APPPOOL[@name=\"#{resource[:name]}\"]").count > 0
	end
	
end