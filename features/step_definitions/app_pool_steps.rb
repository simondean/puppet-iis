require 'nokogiri'

def create_apppool(name)
  success = system(@appcmd, "add", "apppool", "/name:#{name}")
  raise "Failed to add apppool.  Exit code #{$?.exitstatus}" unless success
end

def delete_apppool(name)
  if apppool_exists? name
    success = system(@appcmd, "delete", "apppool", name)
    raise "Failed to delete apppool.  Exit code #{$?.exitstatus}" unless success
  end
end

def apppool_exists?(name)
  output = `#{@appcmd} list apppool /xml`
  raise "Failed to list apppools.  Exit code #{$?.exitstatus}" unless $?.success?
  xml = Nokogiri::XML(output)
  xml.xpath("/appcmd/APPPOOL[@APPPOOL.NAME='#{name}']").length > 0
end

Given /^an app pool called "([^"]*)"$/ do |name|
  delete_apppool name
  create_apppool name
end

Given /^no app pool called "([^"]*)"$/ do |name|
  delete_apppool name
end

Then /^the "([^"]*)" app pool exists$/ do |name|
  apppool_exists?(name).should == true
end

Then /^the "([^"]*)" app pool does not exists$/ do |name|
  apppool_exists?(name).should == false
end