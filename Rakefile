require 'bundler/setup'

require 'puppet-lint/tasks/puppet-lint'
require 'rspec/core/rake_task'

task :default => [:spec, :lint, :smoke_test]

RSpec::Core::RakeTask.new(:spec)

desc "Run test manifests"
task :smoke_test do
	Dir.glob('tests/**/*.pp').each do |test_manifest|
		puts "Applying test manifest #{test_manifest}"
		success = system('bundle', 'exec', 'puppet', 'apply', '--verbose', '--noop', '--detailed-exitcodes', test_manifest)
		raise 'Test manifest failed' unless success
	end
end

desc "Build package"
task :build do
	success = system('bundle', 'exec', 'puppet', 'module', 'build')
	raise 'Build failed' unless success
end

task :apppool_properties do
	require 'nokogiri'
	
	puts "Apppool properties"
	
	command_line = "\"#{File.join(ENV["SystemRoot"], "system32/inetsrv/appcmd.exe")}\" list apppool \"/apppool.name:Classic .NET AppPool\" /xml /config:*"
	xml_text = `#{command_line}`
	
	xml = Nokogiri::XML(xml_text)
	
	xml.xpath("//APPPOOL//*").each do |element|
		element.attributes.each_key do |key|
			
			property = element.path.downcase().gsub('/', '_') + '_'
			property = property.gsub('_appcmd_apppool_add_', '')
			property += key.downcase()
			puts property
		end
	end
end