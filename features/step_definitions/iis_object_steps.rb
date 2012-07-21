require 'nokogiri'

def create_object(iis_type, name)
  success = system(@appcmd, "add", iis_type, "/name:#{name}")
  raise "Failed to add object.  Exit code #{$?.exitstatus}" unless success
end

def delete_object(iis_type, name)
  if object_exists?(iis_type, name)
    success = system(@appcmd, "delete", iis_type, name)
    raise "Failed to delete object.  Exit code #{$?.exitstatus}" unless success
  end
end

def object_exists?(iis_type, name)
  output = `#{@appcmd} list #{iis_type} /xml`
  raise "Failed to list objects.  Exit code #{$?.exitstatus}" unless $?.success?
  xml = Nokogiri::XML(output)

  xml.xpath("/appcmd/#{iis_type.upcase}[@#{iis_type.upcase}.NAME='#{name}']").length > 0
end

def set_object_properties(iis_type, name, properties)
  args = [@appcmd, "set", iis_type, name]
  properties.each do |key, value|
    args << "/#{key.gsub('_', '.')}:#{value}"
  end
  success = system(*args)
  raise "Failed to set object properties.  Exit code #{$?.exitstatus}" unless success
end

def get_object_property(iis_type, name, property)
  output = `#{@appcmd} list #{iis_type} #{name} /xml /config:*`
  raise "Failed to get object properties.  Exit code #{$?.exitstatus}" unless $?.success?
  xml = Nokogiri::XML(output).at_xpath("/appcmd/*/*")

  matches = xml.xpath(property)

  case matches.length
    when 0
      nil
    when 1
      matches.first.value
    else
      raise "xpath matched multiple elements"
  end
end

Given /^an? "([^"]*)" called "([^"]*)"$/ do |iis_type, name|
  @iis_type = iis_type
  @iis_object_name = name
  delete_object iis_type, name
  create_object iis_type, name
end

Given /^no "([^"]*)" called "([^"]*)"$/ do |iis_type, name|
  delete_object iis_type, name
end

Given /^its "([^"]*)" property is set to "([^"]*)"$/ do |name, value|
  set_object_properties @iis_type, @iis_object_name, { name => value }
end

Then /^puppet has created the "([^"]*)" "([^"]*)"$/ do |name, iis_type|
  @iis_type = iis_type
  @iis_object_name = name
  object_exists?(iis_type, name).should == true
end

Then /^puppet has changed the "([^"]*)" "([^"]*)"$/ do |name, iis_type|
  @iis_type = iis_type
  @iis_object_name = name
  object_exists?(iis_type, name).should == true
end

When /^puppet has not changed the "([^"]*)" "([^"]*)"$/ do |name, iis_type|
  @iis_type = iis_type
  @iis_object_name = name
  object_exists?(iis_type, name).should == true
end

When /^puppet has not created the "([^"]*)" "([^"]*)"$/ do |name, iis_type|
  object_exists?(iis_type, name).should == false
end

Then /^puppet has deleted the "([^"]*)" "([^"]*)"$/ do |name, iis_type|
  object_exists?(iis_type, name).should == false
end

Then /^puppet has set its "([^"]*)" property to "([^"]*)"$/ do |name, value|
  get_object_property(@iis_type, @iis_object_name, name).should == value
end

Then /^puppet has unset its "([^"]*)" property$/ do |name|
  get_object_property(@iis_type, @iis_object_name, name).should == nil
end

When /^puppet has left its "([^"]*)" property set to "([^"]*)"$/ do |name, value|
  get_object_property(@iis_type, @iis_object_name, name).should == value
end

When /^puppet has left its "([^"]*)" property unset$/ do |name|
  get_object_property(@iis_type, @iis_object_name, name).should == nil
end