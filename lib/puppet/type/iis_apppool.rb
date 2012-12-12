require File.join(File.dirname(__FILE__), 'iis/iis_file_system_path_property')

Puppet::Type.newtype(:iis_apppool) do
  @doc = "IIS App Pool"

  ensurable

  newparam(:name) do
    desc "App pool name"
  end

  newproperty(:queuelength, :parent => Puppet::IisProperty) do
    desc ""
  end

  newproperty(:autostart, :parent => Puppet::IisProperty) do
    desc ""
  end

  newproperty(:enable32bitapponwin64, :parent => Puppet::IisProperty) do
    desc ""
  end

  newproperty(:managedruntimeversion, :parent => Puppet::IisProperty) do
    desc ""
  end

  newproperty(:managedruntimeloader, :parent => Puppet::IisProperty) do
    desc ""
  end

  newproperty(:enableconfigurationoverride, :parent => Puppet::IisProperty) do
    desc ""
  end

  newproperty(:managedpipelinemode, :parent => Puppet::IisProperty) do
    desc ""
  end

  newproperty(:clrconfigfile, :parent => Puppet::IisProperty) do
    desc ""
  end

  newproperty(:passanonymoustoken, :parent => Puppet::IisProperty) do
    desc ""
  end

  newproperty(:startmode, :parent => Puppet::IisProperty) do
    desc ""
  end

  newproperty(:processmodel_identitytype, :parent => Puppet::IisProperty) do
    desc ""
  end

  newproperty(:processmodel_username, :parent => Puppet::IisProperty) do
    desc ""
  end

  newproperty(:processmodel_password, :parent => Puppet::IisProperty) do
    desc ""
  end

  newproperty(:processmodel_loaduserprofile, :parent => Puppet::IisProperty) do
    desc ""
  end

  newproperty(:processmodel_setprofileenvironment, :parent => Puppet::IisProperty) do
    desc ""
  end

  newproperty(:processmodel_logontype, :parent => Puppet::IisProperty) do
    desc ""
  end

  newproperty(:processmodel_manualgroupmembership, :parent => Puppet::IisProperty) do
    desc ""
  end

  newproperty(:processmodel_idletimeout, :parent => Puppet::IisProperty) do
    desc ""
  end

  newproperty(:processmodel_maxprocesses, :parent => Puppet::IisProperty) do
    desc ""
  end

  newproperty(:processmodel_shutdowntimelimit, :parent => Puppet::IisProperty) do
    desc ""
  end

  newproperty(:processmodel_startuptimelimit, :parent => Puppet::IisProperty) do
    desc ""
  end

  newproperty(:processmodel_pingingenabled, :parent => Puppet::IisProperty) do
    desc ""
  end

  newproperty(:processmodel_pinginterval, :parent => Puppet::IisProperty) do
    desc ""
  end

  newproperty(:processmodel_pingresponsetime, :parent => Puppet::IisProperty) do
    desc ""
  end

  newproperty(:recycling_disallowoverlappingrotation, :parent => Puppet::IisProperty) do
    desc ""
  end

  newproperty(:recycling_disallowrotationonconfigchange, :parent => Puppet::IisProperty) do
    desc ""
  end

  newproperty(:recycling_logeventonrecycle, :parent => Puppet::IisProperty) do
    desc ""
  end

  newproperty(:recycling_periodicrestart_memory, :parent => Puppet::IisProperty) do
    desc ""
  end

  newproperty(:recycling_periodicrestart_privatememory, :parent => Puppet::IisProperty) do
    desc ""
  end

  newproperty(:recycling_periodicrestart_requests, :parent => Puppet::IisProperty) do
    desc ""
  end

  newproperty(:recycling_periodicrestart_time, :parent => Puppet::IisProperty) do
    desc ""
  end

  newproperty(:failure_loadbalancercapabilities, :parent => Puppet::IisProperty) do
    desc ""
  end

  newproperty(:failure_orphanworkerprocess, :parent => Puppet::IisProperty) do
    desc ""
  end

  newproperty(:failure_orphanactionexe, :parent => Puppet::IisProperty) do
    desc ""
  end

  newproperty(:failure_orphanactionparams, :parent => Puppet::IisProperty) do
    desc ""
  end

  newproperty(:failure_rapidfailprotection, :parent => Puppet::IisProperty) do
    desc ""
  end

  newproperty(:failure_rapidfailprotectioninterval, :parent => Puppet::IisProperty) do
    desc ""
  end

  newproperty(:failure_rapidfailprotectionmaxcrashes, :parent => Puppet::IisProperty) do
    desc ""
  end

  newproperty(:failure_autoshutdownexe, :parent => Puppet::IisProperty) do
    desc ""
  end

  newproperty(:failure_autoshutdownparams, :parent => Puppet::IisProperty) do
    desc ""
  end

  newproperty(:cpu_limit, :parent => Puppet::IisProperty) do
    desc ""
  end

  newproperty(:cpu_action, :parent => Puppet::IisProperty) do
    desc ""
  end

  newproperty(:cpu_resetinterval, :parent => Puppet::IisProperty) do
    desc ""
  end

  newproperty(:cpu_smpaffinitized, :parent => Puppet::IisProperty) do
    desc ""
  end

  newproperty(:cpu_smpprocessoraffinitymask, :parent => Puppet::IisProperty) do
    desc ""
  end

  newproperty(:cpu_smpprocessoraffinitymask2, :parent => Puppet::IisProperty) do
    desc ""
  end
end
