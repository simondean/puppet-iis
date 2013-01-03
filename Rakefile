require 'bundler/setup'

require 'rspec/core/rake_task'

task :default => [:spec, :smoke_test]

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
	success = system('bundle', 'exec', 'puppet', 'module', 'build', '.')
	raise 'Build failed' unless success
end

desc "Run acceptance tests"
task :acceptance_test do
  success = system('bundle', 'exec', 'cucumber', '--strict')
  raise 'Build failed' unless success
end

task :iis_object_properties do
	require 'nokogiri'
	
	['site', 'app', 'vdir', 'apppool', 'config', 'wp', 'request', 'module', 'backup', 'trace'].each do |iis_type|
		puts ":#{iis_type}"
		
		command_line = "\"#{File.join(ENV["SystemRoot"], "system32/inetsrv/appcmd.exe")}\" list #{iis_type} /xml /config:*"
		xml_text = `#{command_line}`
		
		xml = Nokogiri::XML(xml_text)
		
		xml.xpath("/appcmd/#{iis_type.upcase}[1]/descendant::*").each do |element|
			element.attributes.each_key do |key|
        key = "#{element.path}/#{key}".gsub(/\/appcmd\/[^\/]+\/([^\/]+\/)?/, "").gsub("/", "_").downcase
				puts "   :#{key},"
			end
    end

    puts ""
	end
end
