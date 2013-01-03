require 'win32/dir'

Before do
  @appcmd = File.join(ENV['SystemRoot'], 'system32/inetsrv/appcmd.exe')

  @module_path = 'features/temp/modules'
  iis_module_path = "#{@module_path}/iis"
  
  Dir.delete @module_path if Dir.exists? @module_path and Dir.junction? @module_path

  FileUtils.mkdir_p @module_path
  Dir.create_junction iis_module_path, '.'
end
