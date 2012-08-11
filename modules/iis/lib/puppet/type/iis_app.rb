Puppet::Type.newtype(:iis_app) do
  @doc = "IIS App"

  ensurable

  newparam(:name) do
    desc "App name"

    newvalues(/.+\/.*/)
  end

  [:applicationpool,
   :enabledprotocols,
   :serviceautostartenabled,
   :serviceautostartprovider,
   :virtualdirectorydefaults_path,
   :virtualdirectorydefaults_physicalpath,
   :virtualdirectorydefaults_username,
   :virtualdirectorydefaults_password,
   :virtualdirectorydefaults_logonmethod,
   :virtualdirectorydefaults_allowsubdirconfig].each do |property|
    newproperty(property) do
      munge do |value|
        value.to_s
      end
    end
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
