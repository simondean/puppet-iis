Puppet::Type.newtype(:iis_vdir) do
  @doc = "IIS Virtual Directory"

  ensurable

  newparam(:name) do
    desc "Virtual directory name"

    newvalues(/.+\/.*/)
  end

  newparam(:iis_app) do
    desc "Path of the app the virtual directory is under"
  end

  [:physicalpath,
   :username,
   :password,
   :logonmethod,
   :allowsubdirconfig].each do |property|
    newproperty(property) do
      munge do |value|
        value.to_s
      end
    end
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
  end
end
