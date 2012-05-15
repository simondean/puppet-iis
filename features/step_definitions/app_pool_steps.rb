require 'nokogiri'

def create_apppool(name)
  success = system(@appcmd, "add", "apppool", "/name:#{name}")
  raise "Failed to add app pool.  Exit code #{$?.exitstatus}" unless success
end

def delete_apppool(name)
  if apppool_exists? name
    success = system(@appcmd, "delete", "apppool", name)
    raise "Failed to delete app pool.  Exit code #{$?.exitstatus}" unless success
  end
end

def apppool_exists?(name)
  output = `#{@appcmd} list apppool /xml`
  raise "Failed to list app pools.  Exit code #{$?.exitstatus}" unless $?.success?
  xml = Nokogiri::XML(output)
  xml.xpath("/appcmd/APPPOOL[@APPPOOL.NAME='#{name}']").length > 0
end

def set_apppool_properties(name, properties)
  args = [@appcmd, "set", "apppool", name]
  properties.each do |key, value|
    args << "/#{key.gsub('_', '.')}:#{value}"
  end
  success = system(*args)
  raise "Failed to set app ppool properties.  Exit code #{$?.exitstatus}" unless success
end

def get_apppool_properties(name)
  output = `#{@appcmd} list apppool #{name} /xml /config:*`
  raise "Failed to get app pool properties.  Exit code #{$?.exitstatus}" unless $?.success?
  xml = Nokogiri::XML(output)

  properties = {}

  xml.xpath("/appcmd/APPPOOL/add/descendant-or-self::*").each do |element|
    element.attributes.each do |key, attribute|
      key = "#{element.path}/#{key}"
        .gsub("/appcmd/APPPOOL/add/", "")
        .gsub("/", "_")
        .downcase
      properties[key] = attribute.value
    end
  end

  properties
end

Given /^an app pool called "([^"]*)"$/ do |name|
  @apppool_name = name
  delete_apppool name
  create_apppool name
end

Given /^no app pool called "([^"]*)"$/ do |name|
  delete_apppool name
end

Given /^its "([^"]*)" property is set to "([^"]*)"$/ do |name, value|
  set_apppool_properties @apppool_name, { name => value }
end

Then /^puppet has created the "([^"]*)" app pool$/ do |name|
  apppool_exists?(name).should == true
end

Then /^puppet has deleted the "([^"]*)" app pool$/ do |name|
  apppool_exists?(name).should == false
end

Then /^puppet has changed the "([^"]*)" app pool$/ do |name|
  @apppool_name = name
end

Then /^puppet has set its "([^"]*)" property to "([^"]*)"$/ do |name, value|
  get_apppool_properties(@apppool_name)[name].should == value
end