require 'nokogiri'

def create_object(object_type, name)
  args = [@appcmd, "add", object_type]

  case object_type.to_sym
    when :app
      site_name, path = name.split('/', 2)
      path = "/#{path}"
      args << "/site.name:#{site_name}" << "/path:#{path}"
    else
      args << "/name:#{name}"
  end

  success = system(*args)
  raise "Failed to add object.  Exit code #{$?.exitstatus}" unless success
end

def delete_object(object_type, name)
  if object_exists?(object_type, name)
    success = system(@appcmd, "delete", object_type, name)
    raise "Failed to delete object.  Exit code #{$?.exitstatus}" unless success
  end
end

def object_exists?(object_type, name)
  output = `#{@appcmd} list #{object_type} /xml`
  raise "Failed to list objects.  Exit code #{$?.exitstatus}" unless $?.success?
  xml = Nokogiri::XML(output)

  (xml.xpath("/appcmd/#{object_type.upcase}[@#{object_type.upcase}.NAME='#{name}']").length > 0)
end

def set_object_properties(object_type, name, properties)
  args = [@appcmd, "set", object_type, name]
  properties.each do |key, value|
    args << "/#{key.gsub('_', '.')}:#{value}"
  end
  puts args
  success = system(*args)
  raise "Failed to set object properties.  Exit code #{$?.exitstatus}" unless success
end

def set_object_property(object_type, name, property)
  success = system(@appcmd, "set", object_type, name, property)
  raise "Failed to set object property.  Exit code #{$?.exitstatus}" unless success
end

def get_object_property(object_type, name, property)
  output = `#{@appcmd} list #{object_type} #{name} /xml /config:*`
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

Given /^an? "([^"]*)" called "([^"]*)"$/ do |object_type, name|
  case object_type.to_sym
    when :directory
      FileUtils.mkdir_p name
    else
      @object_type = object_type
      @object_name = name
      delete_object object_type, name
      create_object object_type, name
  end
end

Given /^no "([^"]*)" called "([^"]*)"$/ do |object_type, name|
  delete_object object_type, name
end

Given /^its "([^"]*)" property is set to "([^"]*)"$/ do |name, value|
  set_object_properties @object_type, @object_name, { name => value }
end

Given /^it has the property "([^"]*)"$/ do |property|
  set_object_property @object_type, @object_name, property
end

Then /^puppet has created the "([^"]*)" "([^"]*)"$/ do |name, object_type|
  @object_type = object_type
  @object_name = name
  object_exists?(object_type, name).should == true
end

Then /^puppet has changed the "([^"]*)" "([^"]*)"$/ do |name, object_type|
  @object_type = object_type
  @object_name = name
  object_exists?(object_type, name).should == true
end

When /^puppet has not changed the "([^"]*)" "([^"]*)"$/ do |name, object_type|
  @object_type = object_type
  @object_name = name
  object_exists?(object_type, name).should == true
end

When /^puppet has not created the "([^"]*)" "([^"]*)"$/ do |name, object_type|
  object_exists?(object_type, name).should == false
end

Then /^puppet has deleted the "([^"]*)" "([^"]*)"$/ do |name, object_type|
  object_exists?(object_type, name).should == false
end

Then /^puppet has set its "([^"]*)" property to "([^"]*)"$/ do |name, value|
  get_object_property(@object_type, @object_name, name).should == value
end

Then /^puppet has unset its "([^"]*)" property$/ do |name|
  get_object_property(@object_type, @object_name, name).should == nil
end

When /^puppet has left its "([^"]*)" property set to "([^"]*)"$/ do |name, value|
  get_object_property(@object_type, @object_name, name).should == value
end

When /^puppet has left its "([^"]*)" property unset$/ do |name|
  get_object_property(@object_type, @object_name, name).should == nil
end
