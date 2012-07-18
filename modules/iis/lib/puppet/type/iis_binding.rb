Puppet::Type.newtype(:iis_site) do
  @doc = "IIS Site"

  ensurable

  newparam(:name) do
    desc "Binding name"
  end

  ["iis_site"].each do |property|
		newproperty(property.to_sym()) do
      munge do |value|
        value.to_s
      end
    end
  end

  #autorequire(:iis_site) do
  #  iis_site
  #end
end
