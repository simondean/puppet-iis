Puppet::Type.newtype(:iis_app) do
  @doc = "IIS App"

  class IisProperty < Puppet::Property
    munge do |value|
      value.to_s
    end
  end

  class IisPhysicalPathProperty < IisProperty
    def insync?(is)
      self.is_to_s(is).casecmp(self.should_to_s(@should).gsub('/', '\\')) == 0
    end
  end

  ensurable

  newparam(:name) do
    desc "App name"

    newvalues(/.+\/.*/)
  end

  newproperty(:applicationpool, :parent => IisProperty) do
    desc "Application pool the application is assigned to"
  end

  newproperty(:enabledprotocols, :parent => IisProperty) do
    desc "Enabled protocols"
  end

  newproperty(:serviceautostartenabled, :parent => IisProperty) do
    desc "Whether autostart is enabled"
  end

  newproperty(:serviceautostartprovider, :parent => IisProperty) do
    desc "Name of the autostart provider, if enabled"
  end

  newproperty(:virtualdirectorydefaults_path, :parent => IisProperty) do
    desc "Virtual directory defaults: Virtual directory path"
  end

  newproperty(:virtualdirectorydefaults_physicalpath, :parent => IisPhysicalPathProperty) do
    desc "Virtual directory defaults: Physical path"
  end

  newproperty(:virtualdirectorydefaults_logonmethod, :parent => IisProperty) do
    desc "Virtual directory defaults: Logon method for the physical path"
  end

  newproperty(:virtualdirectorydefaults_username, :parent => IisProperty) do
    desc "Virtual directory defaults: User name that can access the physical path"
  end

  newproperty(:virtualdirectorydefaults_password, :parent => IisProperty) do
    desc "Virtual directory defaults: Password for the user name"
  end

  newproperty(:virtualdirectorydefaults_allowsubdirconfig, :parent => IisProperty) do
    desc "Virtual directory defaults: Controls whether IIS will load just the Web.config file in the physical path (false) or also the Web.config files in the sub-directories of the physical path (true)"
  end

  autorequire(:iis_site) do
    self[:name].split('/')[0]
  end

  autorequire(:iis_apppool) do
    self[:applicationpool]
  end

  validate do
    [:applicationpool].each do |attribute|
      raise Puppet::Error, "Attribute '#{attribute}' is mandatory" unless self[attribute]
    end

    name = self[:name]

    name = name.chomp('/')
    name += '/' if name.count('/') == 0

    raise Puppet::Error, "iis_app name should be '#{name}'" unless self[:name] == name
  end
end
