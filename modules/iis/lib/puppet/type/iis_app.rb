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
end
