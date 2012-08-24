Given /^a directory called "([^"]*)"$/ do |name|
  FileUtils.mkdir_p name
end