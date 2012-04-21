require 'bundler/setup'

require 'puppet-lint/tasks/puppet-lint'
require 'rspec/core/rake_task'

task :default => [:spec, :lint, :smoke_test]

RSpec::Core::RakeTask.new(:spec)

desc "Run test manifests"
task :smoke_test do
	Dir.glob('tests/**/*.pp').each do |test_manifest|
		puts "Applying test manifest #{test_manifest}"
		success = system('bundle', 'exec', 'puppet', 'apply', '--verbose', '--noop', test_manifest)
		raise 'Test manifest failed' unless success
	end
end

desc "Build package"
task :build do
	success = system('bundle', 'exec', 'puppet', 'module', 'build')
	raise 'Build failed' unless success
end
