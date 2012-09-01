Puppet::Type.newtype(:iis_vdir) do
  @doc = "IIS Virtual Directory"

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
    desc "Virtual directory name"

    newvalues(/.+\/.*/)
  end

  newparam(:iis_app) do
    desc "Path of the app the virtual directory is under"
  end

  newproperty(:physicalpath, :parent => IisPhysicalPathProperty) do
    desc "Physical path"
  end

  newproperty(:logonmethod, :parent => IisProperty) do
    desc "Logon method for the physical path"
  end

  newproperty(:username, :parent => IisProperty) do
    desc "User name that can access the physical path"
  end

  newproperty(:password, :parent => IisProperty) do
    desc "Password for the user name"
  end

  newproperty(:allowsubdirconfig, :parent => IisProperty) do
    desc "Controls whether IIS will load just the Web.config file in the physical path (false) or also the Web.config files in the sub-directories of the physical path (true)"
  end

  autorequire(:iis_site) do
    self[:name].split('/')[0]
  end

  autorequire(:iis_app) do
    self[:iis_app]
  end

  validate do
    [:iis_app].each do |attribute|
      raise Puppet::Error, "Attribute '#{attribute}' is mandatory" unless self[attribute]
    end

    iis_app = self[:iis_app]
    name = self[:name]

    raise Puppet::Error, "name should start with '#{iis_app.chomp('/')}'" unless ensure_trailing_slash(name).start_with?(ensure_trailing_slash(iis_app))

    iis_app = iis_app.chomp('/')
    iis_app += '/' if iis_app.count('/') == 0

    name = ensure_trailing_slash(name)

    if name.length > ensure_trailing_slash(iis_app).length
      name = name.chomp('/')
    end

    raise Puppet::Error, "iis_vdir name should be '#{name}'" unless self[:name] == name
    raise Puppet::Error, "iis_vdir attribute iis_app should be set to '#{iis_app}'" unless self[:iis_app] == iis_app
  end

  def ensure_trailing_slash(value)
    (value.end_with?('/')) ? value : (value + '/')
  end
end
