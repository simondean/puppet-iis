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
end
