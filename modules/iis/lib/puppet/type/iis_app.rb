require File.join(File.dirname(__FILE__), 'iis/iis_file_system_path_property')

Puppet::Type.newtype(:iis_app) do
  @doc = "IIS App"

  ensurable

  newparam(:name) do
    desc "App name"

    newvalues(/.+\/.*/)
  end

  newproperty(:applicationpool, :parent => Puppet::IisProperty) do
    desc "Application pool the application is assigned to"

    isrequired
  end

  newproperty(:enabledprotocols, :parent => Puppet::IisProperty) do
    desc "Enabled protocols"
  end

  newproperty(:serviceautostartenabled, :parent => Puppet::IisProperty) do
    desc "Whether autostart is enabled"
  end

  newproperty(:serviceautostartprovider, :parent => Puppet::IisProperty) do
    desc "Name of the autostart provider, if enabled"
  end

  newproperty(:virtualdirectorydefaults_path, :parent => Puppet::IisProperty) do
    desc "Virtual directory defaults: Virtual directory virtual path"
  end

  newproperty(:virtualdirectorydefaults_physicalpath, :parent => Puppet::IisFileSystemPathProperty) do
    desc "Virtual directory defaults: Physical path"
  end

  newproperty(:virtualdirectorydefaults_logonmethod, :parent => Puppet::IisProperty) do
    desc "Virtual directory defaults: Logon method for the physical path"
  end

  newproperty(:virtualdirectorydefaults_username, :parent => Puppet::IisProperty) do
    desc "Virtual directory defaults: User name that can access the physical path"
  end

  newproperty(:virtualdirectorydefaults_password, :parent => Puppet::IisProperty) do
    desc "Virtual directory defaults: Password for the user name"
  end

  newproperty(:virtualdirectorydefaults_allowsubdirconfig, :parent => Puppet::IisProperty) do
    desc "Virtual directory defaults: Controls whether IIS will load just the Web.config file in the physical path (false) or also the Web.config files in the sub-directories of the physical path (true)"
  end

  autorequire(:iis_site) do
    self[:name].split('/')[0]
  end

  autorequire(:iis_apppool) do
    self[:applicationpool]
  end

  validate do
    name = self[:name]

    name = name.chomp('/')
    name += '/' if name.count('/') == 0

    raise Puppet::Error, "iis_app name should be '#{name}'" unless self[:name] == name
  end
end
