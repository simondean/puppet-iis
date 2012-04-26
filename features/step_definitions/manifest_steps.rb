Given /^the manifest$/ do |text|
  @manifest = text
end
When /^the manifest is applied$/ do
  IO.popen(['bundle', 'exec', 'puppet', 'apply', '--verbose'], 'r+') do |process|
    process.puts @manifest
    process.close_write
    puts process.gets
  end

  raise "puppet apply failed.  Exit code #{$?.exitstatus}" unless $?.exitstatus == 0
end