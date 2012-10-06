require 'nokogiri'

def create_object(object_type, name)
  success = system(@appcmd, "add", object_type, "/name:#{name}")
  raise "Failed to add object.  Exit code #{$?.exitstatus}" unless success
end

def create_app(name)
  site_name, path = name.split('/', 2)
  path = "/#{path}"

  success = system(@appcmd, "add", "app", "/site.name:#{site_name}", "/path:#{path}")
  raise "Failed to add object.  Exit code #{$?.exitstatus}" unless success
end

def create_vdir(app_name, name)
  path = name[(app_name.chomp('/').length)..-1]
  success = system(@appcmd, "add", "vdir", "/app.name:#{app_name}", "/path:#{path}")
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
  success = [0, 1].include? $?.exitstatus
  raise "Failed to list objects.  Exit code #{$?.exitstatus}" unless success
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
  output = `#{@appcmd} list "#{object_type}" "#{name}" /xml /config:*`
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

Given /^an? (app|apppool|site|vdir) called "([^"]*)"$/ do |object_type, name|
  @object_type = object_type
  @object_name = name
  delete_object @object_type, @object_name

  case object_type.to_sym
    when :app
      create_app @object_name
    else
      create_object @object_type, @object_name
  end
end

Given /^a vdir called "([^"]*)" for "([^"]*)" app$/ do |name, app_name|
  @object_type = "vdir"
  @object_name = name
  delete_object @object_type, @object_name
  create_vdir app_name, @object_name
end

Given /^no (app|apppool|site|vdir) called "([^"]*)"$/ do |object_type, name|
  delete_object object_type, name
end

Given /^its "([^"]*)" property is set to "([^"]*)"$/ do |name, value|
  set_object_properties @object_type, @object_name, { name => value }
end

Given /^it has the property "([^"]*)"$/ do |property|
  set_object_property @object_type, @object_name, property
end

Then /^puppet has created the "([^"]*)" (app|apppool|site|vdir)$/ do |name, object_type|
  @object_type = object_type
  @object_name = name
  object_exists?(object_type, name).should == true
end

Then /^puppet has changed the "([^"]*)" (app|apppool|site|vdir)$/ do |name, object_type|
  @object_type = object_type
  @object_name = name
  object_exists?(object_type, name).should == true
end

When /^puppet has not changed the "([^"]*)" (app|apppool|site|vdir)$/ do |name, object_type|
  @object_type = object_type
  @object_name = name
  object_exists?(object_type, name).should == true
end

When /^puppet has not created the "([^"]*)" (app|apppool|site|vdir)$/ do |name, object_type|
  object_exists?(object_type, name).should == false
end

Then /^puppet has deleted the "([^"]*)" (app|apppool|site|vdir)$/ do |name, object_type|
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
