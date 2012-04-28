Puppet::Type.newtype(:iis_apppool) do
  @doc = "IIS App Pool"

  ensurable do
    desc "Ensures the app pool is present or absent"

    newvalue(:present, :event => :iis_apppool_created) #do
    #  provider.create
    #end

    newvalue(:absent, :event => :iis_apppool_destroyed) #do
    #  provider.destroy
    #end
  end

  newparam(:name) do
    desc "App pool name"
  end

  ['queuelength',
	 'autostart',
	 'enable32bitapponwin64',
	 'managedruntimeversion',
	 'managedruntimeloader',
	 'enableconfigurationoverride',
	 'managedpipelinemode',
	 'clrconfigfile',
	 'passanonymoustoken',
	 'startmode',
	 'processmodel_identitytype',
	 'processmodel_username',
	 'processmodel_password',
	 'processmodel_loaduserprofile',
	 'processmodel_setprofileenvironment',
	 'processmodel_logontype',
	 'processmodel_manualgroupmembership',
	 'processmodel_idletimeout',
	 'processmodel_maxprocesses',
	 'processmodel_shutdowntimelimit',
	 'processmodel_startuptimelimit',
	 'processmodel_pingingenabled',
	 'processmodel_pinginterval',
	 'processmodel_pingresponsetime',
	 'recycling_disallowoverlappingrotation',
	 'recycling_disallowrotationonconfigchange',
	 'recycling_logeventonrecycle',
	 'recycling_periodicrestart_memory',
	 'recycling_periodicrestart_privatememory',
	 'recycling_periodicrestart_requests',
	 'recycling_periodicrestart_time',
	 'failure_loadbalancercapabilities',
	 'failure_orphanworkerprocess',
	 'failure_orphanactionexe',
	 'failure_orphanactionparams',
	 'failure_rapidfailprotection',
	 'failure_rapidfailprotectioninterval',
	 'failure_rapidfailprotectionmaxcrashes',
	 'failure_autoshutdownexe',
	 'failure_autoshutdownparams',
	 'cpu_limit',
	 'cpu_action',
	 'cpu_resetinterval',
	 'cpu_smpaffinitized',
	 'cpu_smpprocessoraffinitymask',
	 'cpu_smpprocessoraffinitymask2'].each do |property|
		newproperty(property.to_sym())
  end

  #def exists?
  #  @provider.get(:ensure) != :absent
  #end
end
