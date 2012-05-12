require 'nokogiri'

def delete_apppool(name)
  success = system(@appcmd, "delete", "apppool", name)
  raise "Failed to delete apppool.  Exit code #{$?.exitstatus}" unless success
end

def apppool_exists?(name)
  output = `#{@appcmd} list apppool /xml`
  raise "Failed to list apppools.  Exit code #{$?.exitstatus}" unless $?.success?
  xml = Nokogiri::XML(output)
  xml.xpath("/appcmd/APPPOOL[@APPPOOL.NAME='#{name}']").length > 0
end

Given /^there is no app pool named "([^"]*)"$/ do |name|
  delete_apppool name if apppool_exists? name
end

Then /^there is an app pool named "([^"]*)"$/ do |name|
  apppool_exists?(name).should == true
end