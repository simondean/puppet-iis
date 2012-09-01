Puppet::Type.newtype(:iis_apppool) do
  @doc = "IIS App Pool"

  class IisProperty < Puppet::Property
    munge do |value|
      value.to_s
    end
  end

  ensurable

  newparam(:name) do
    desc "App pool name"
  end

  newproperty(:queuelength, :parent => IisProperty) do
    desc ""
  end

  newproperty(:autostart, :parent => IisProperty) do
    desc ""
  end

  newproperty(:enable32bitapponwin64, :parent => IisProperty) do
    desc ""
  end

  newproperty(:managedruntimeversion, :parent => IisProperty) do
    desc ""
  end

  newproperty(:managedruntimeloader, :parent => IisProperty) do
    desc ""
  end

  newproperty(:enableconfigurationoverride, :parent => IisProperty) do
    desc ""
  end

  newproperty(:managedpipelinemode, :parent => IisProperty) do
    desc ""
  end

  newproperty(:clrconfigfile, :parent => IisProperty) do
    desc ""
  end

  newproperty(:passanonymoustoken, :parent => IisProperty) do
    desc ""
  end

  newproperty(:startmode, :parent => IisProperty) do
    desc ""
  end

  newproperty(:processmodel_identitytype, :parent => IisProperty) do
    desc ""
  end

  newproperty(:processmodel_username, :parent => IisProperty) do
    desc ""
  end

  newproperty(:processmodel_password, :parent => IisProperty) do
    desc ""
  end

  newproperty(:processmodel_loaduserprofile, :parent => IisProperty) do
    desc ""
  end

  newproperty(:processmodel_setprofileenvironment, :parent => IisProperty) do
    desc ""
  end

  newproperty(:processmodel_logontype, :parent => IisProperty) do
    desc ""
  end

  newproperty(:processmodel_manualgroupmembership, :parent => IisProperty) do
    desc ""
  end

  newproperty(:processmodel_idletimeout, :parent => IisProperty) do
    desc ""
  end

  newproperty(:processmodel_maxprocesses, :parent => IisProperty) do
    desc ""
  end

  newproperty(:processmodel_shutdowntimelimit, :parent => IisProperty) do
    desc ""
  end

  newproperty(:processmodel_startuptimelimit, :parent => IisProperty) do
    desc ""
  end

  newproperty(:processmodel_pingingenabled, :parent => IisProperty) do
    desc ""
  end

  newproperty(:processmodel_pinginterval, :parent => IisProperty) do
    desc ""
  end

  newproperty(:processmodel_pingresponsetime, :parent => IisProperty) do
    desc ""
  end

  newproperty(:recycling_disallowoverlappingrotation, :parent => IisProperty) do
    desc ""
  end

  newproperty(:recycling_disallowrotationonconfigchange, :parent => IisProperty) do
    desc ""
  end

  newproperty(:recycling_logeventonrecycle, :parent => IisProperty) do
    desc ""
  end

  newproperty(:recycling_periodicrestart_memory, :parent => IisProperty) do
    desc ""
  end

  newproperty(:recycling_periodicrestart_privatememory, :parent => IisProperty) do
    desc ""
  end

  newproperty(:recycling_periodicrestart_requests, :parent => IisProperty) do
    desc ""
  end

  newproperty(:recycling_periodicrestart_time, :parent => IisProperty) do
    desc ""
  end

  newproperty(:failure_loadbalancercapabilities, :parent => IisProperty) do
    desc ""
  end

  newproperty(:failure_orphanworkerprocess, :parent => IisProperty) do
    desc ""
  end

  newproperty(:failure_orphanactionexe, :parent => IisProperty) do
    desc ""
  end

  newproperty(:failure_orphanactionparams, :parent => IisProperty) do
    desc ""
  end

  newproperty(:failure_rapidfailprotection, :parent => IisProperty) do
    desc ""
  end

  newproperty(:failure_rapidfailprotectioninterval, :parent => IisProperty) do
    desc ""
  end

  newproperty(:failure_rapidfailprotectionmaxcrashes, :parent => IisProperty) do
    desc ""
  end

  newproperty(:failure_autoshutdownexe, :parent => IisProperty) do
    desc ""
  end

  newproperty(:failure_autoshutdownparams, :parent => IisProperty) do
    desc ""
  end

  newproperty(:cpu_limit, :parent => IisProperty) do
    desc ""
  end

  newproperty(:cpu_action, :parent => IisProperty) do
    desc ""
  end

  newproperty(:cpu_resetinterval, :parent => IisProperty) do
    desc ""
  end

  newproperty(:cpu_smpaffinitized, :parent => IisProperty) do
    desc ""
  end

  newproperty(:cpu_smpprocessoraffinitymask, :parent => IisProperty) do
    desc ""
  end

  newproperty(:cpu_smpprocessoraffinitymask2, :parent => IisProperty) do
    desc ""
  end
end
