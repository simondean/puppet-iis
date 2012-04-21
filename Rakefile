require 'puppet-lint/tasks/puppet-lint'

task :default => [:lint, :smoke_test]

task :smoke_test do
	Dir.glob('tests/**/*.pp').each do |test_manifest|
		puts "Applying test manifest #{test_manifest}"
		success = system('bundle', 'exec', 'puppet', 'apply', '--verbose', '--noop', test_manifest)
		raise 'Test manifest failed' unless success
	end
end