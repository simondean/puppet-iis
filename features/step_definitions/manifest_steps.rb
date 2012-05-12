require 'tempfile'

Given /^the manifest$/ do |text|
  @manifest = text
end

When /^the manifest is applied$/ do
  manifest_file = Tempfile.new('manifest')

  begin
    manifest_file.write @manifest
    manifest_file.close

    success = system('bundle', 'exec', 'puppet', 'apply', '--debug', '--detailed-exitcodes', manifest_file.path)
    raise "puppet apply failed.  Exit code #{$?.exitstatus}" unless success
  ensure
    manifest_file.delete
  end
end