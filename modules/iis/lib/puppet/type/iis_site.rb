Puppet::Type.newtype(:iis_site) do
  @doc = "IIS Site"

  class IisProperty < Puppet::Property
    munge do |value|
      value.to_s
    end
  end

  ensurable

  newparam(:name) do
    desc "Site name"
  end

  newproperty(:id, :parent => IisProperty) do
    desc ""
  end

  newproperty(:serverautostart, :parent => IisProperty) do
    desc ""
  end

  newproperty(:limits_maxbandwidth, :parent => IisProperty) do
    desc ""
  end

  newproperty(:limits_maxconnections, :parent => IisProperty) do
    desc ""
  end

  newproperty(:limits_connectiontimeout, :parent => IisProperty) do
    desc ""
  end

  newproperty(:logfile_logextfileflags, :parent => IisProperty) do
    desc ""
  end

  newproperty(:logfile_customlogpluginclsid, :parent => IisProperty) do
    desc ""
  end

  newproperty(:logfile_logformat, :parent => IisProperty) do
    desc ""
  end

  newproperty(:logfile_directory, :parent => IisProperty) do
    desc ""
  end

  newproperty(:logfile_period, :parent => IisProperty) do
    desc ""
  end

  newproperty(:logfile_truncatesize, :parent => IisProperty) do
    desc ""
  end

  newproperty(:logfile_localtimerollover, :parent => IisProperty) do
    desc ""
  end

  newproperty(:logfile_enabled, :parent => IisProperty) do
    desc ""
  end

  newproperty(:tracefailedrequestslogging_enabled, :parent => IisProperty) do
    desc ""
  end

  newproperty(:tracefailedrequestslogging_directory, :parent => IisProperty) do
    desc ""
  end

  newproperty(:tracefailedrequestslogging_maxlogfiles, :parent => IisProperty) do
    desc ""
  end

  newproperty(:tracefailedrequestslogging_maxlogfilesizekb, :parent => IisProperty) do
    desc ""
  end

  newproperty(:tracefailedrequestslogging_customactionsenabled, :parent => IisProperty) do
    desc ""
  end

  newproperty(:applicationdefaults_path, :parent => IisProperty) do
    desc ""
  end

  newproperty(:applicationdefaults_applicationpool, :parent => IisProperty) do
    desc ""
  end

  newproperty(:applicationdefaults_enabledprotocols, :parent => IisProperty) do
    desc ""
  end

  newproperty(:applicationdefaults_serviceautostartenabled, :parent => IisProperty) do
    desc ""
  end

  newproperty(:applicationdefaults_serviceautostartprovider, :parent => IisProperty) do
    desc ""
  end

  newproperty(:virtualdirectorydefaults_path, :parent => IisProperty) do
    desc ""
  end

  newproperty(:virtualdirectorydefaults_physicalpath, :parent => IisProperty) do
    desc ""
  end

  newproperty(:virtualdirectorydefaults_username, :parent => IisProperty) do
    desc ""
  end

  newproperty(:virtualdirectorydefaults_password, :parent => IisProperty) do
    desc ""
  end

  newproperty(:virtualdirectorydefaults_logonmethod, :parent => IisProperty) do
    desc ""
  end

  newproperty(:virtualdirectorydefaults_allowsubdirconfig, :parent => IisProperty) do
    desc ""
  end

  newproperty(:ftpserver_allowutf8, :parent => IisProperty) do
    desc ""
  end

  newproperty(:ftpserver_serverautostart, :parent => IisProperty) do
    desc ""
  end

  newproperty(:ftpserver_connections_unauthenticatedtimeout, :parent => IisProperty) do
    desc ""
  end

  newproperty(:ftpserver_connections_controlchanneltimeout, :parent => IisProperty) do
    desc ""
  end

  newproperty(:ftpserver_connections_datachanneltimeout, :parent => IisProperty) do
    desc ""
  end

  newproperty(:ftpserver_connections_disablesocketpooling, :parent => IisProperty) do
    desc ""
  end

  newproperty(:ftpserver_connections_serverlistenbacklog, :parent => IisProperty) do
    desc ""
  end

  newproperty(:ftpserver_connections_minbytespersecond, :parent => IisProperty) do
    desc ""
  end

  newproperty(:ftpserver_connections_maxconnections, :parent => IisProperty) do
    desc ""
  end

  newproperty(:ftpserver_connections_resetonmaxconnections, :parent => IisProperty) do
    desc ""
  end

  newproperty(:ftpserver_connections_maxbandwidth, :parent => IisProperty) do
    desc ""
  end

  newproperty(:ftpserver_security_datachannelsecurity_matchclientaddressforport, :parent => IisProperty) do
    desc ""
  end

  newproperty(:ftpserver_security_datachannelsecurity_matchclientaddressforpasv, :parent => IisProperty) do
    desc ""
  end

  newproperty(:ftpserver_security_commandfiltering_maxcommandline, :parent => IisProperty) do
    desc ""
  end

  newproperty(:ftpserver_security_commandfiltering_allowunlisted, :parent => IisProperty) do
    desc ""
  end

  newproperty(:ftpserver_security_ssl_servercerthash, :parent => IisProperty) do
    desc ""
  end

  newproperty(:ftpserver_security_ssl_servercertstorename, :parent => IisProperty) do
    desc ""
  end

  newproperty(:ftpserver_security_ssl_ssl128, :parent => IisProperty) do
    desc ""
  end

  newproperty(:ftpserver_security_ssl_controlchannelpolicy, :parent => IisProperty) do
    desc ""
  end

  newproperty(:ftpserver_security_ssl_datachannelpolicy, :parent => IisProperty) do
    desc ""
  end

  newproperty(:ftpserver_security_sslclientcertificates_clientcertificatepolicy, :parent => IisProperty) do
    desc ""
  end

  newproperty(:ftpserver_security_sslclientcertificates_useactivedirectorymapping, :parent => IisProperty) do
    desc ""
  end

  newproperty(:ftpserver_security_sslclientcertificates_validationflags, :parent => IisProperty) do
    desc ""
  end

  newproperty(:ftpserver_security_sslclientcertificates_revocationfreshnesstime, :parent => IisProperty) do
    desc ""
  end

  newproperty(:ftpserver_security_sslclientcertificates_revocationurlretrievaltimeout, :parent => IisProperty) do
    desc ""
  end

  newproperty(:ftpserver_security_authentication_anonymousauthentication_enabled, :parent => IisProperty) do
    desc ""
  end

  newproperty(:ftpserver_security_authentication_anonymousauthentication_username, :parent => IisProperty) do
    desc ""
  end

  newproperty(:ftpserver_security_authentication_anonymousauthentication_password, :parent => IisProperty) do
    desc ""
  end

  newproperty(:ftpserver_security_authentication_anonymousauthentication_defaultlogondomain, :parent => IisProperty) do
    desc ""
  end

  newproperty(:ftpserver_security_authentication_anonymousauthentication_logonmethod, :parent => IisProperty) do
    desc ""
  end

  newproperty(:ftpserver_security_authentication_basicauthentication_enabled, :parent => IisProperty) do
    desc ""
  end

  newproperty(:ftpserver_security_authentication_basicauthentication_defaultlogondomain, :parent => IisProperty) do
    desc ""
  end

  newproperty(:ftpserver_security_authentication_basicauthentication_logonmethod, :parent => IisProperty) do
    desc ""
  end

  newproperty(:ftpserver_security_authentication_clientcertauthentication_enabled, :parent => IisProperty) do
    desc ""
  end

  newproperty(:ftpserver_messages_exitmessage, :parent => IisProperty) do
    desc ""
  end

  newproperty(:ftpserver_messages_greetingmessage, :parent => IisProperty) do
    desc ""
  end

  newproperty(:ftpserver_messages_bannermessage, :parent => IisProperty) do
    desc ""
  end

  newproperty(:ftpserver_messages_maxclientsmessage, :parent => IisProperty) do
    desc ""
  end

  newproperty(:ftpserver_messages_suppressdefaultbanner, :parent => IisProperty) do
    desc ""
  end

  newproperty(:ftpserver_messages_allowlocaldetailederrors, :parent => IisProperty) do
    desc ""
  end

  newproperty(:ftpserver_messages_expandvariables, :parent => IisProperty) do
    desc ""
  end

  newproperty(:ftpserver_filehandling_keeppartialuploads, :parent => IisProperty) do
    desc ""
  end

  newproperty(:ftpserver_filehandling_allowreplaceonrename, :parent => IisProperty) do
    desc ""
  end

  newproperty(:ftpserver_filehandling_allowreaduploadsinprogress, :parent => IisProperty) do
    desc ""
  end

  newproperty(:ftpserver_firewallsupport_externalip4address, :parent => IisProperty) do
    desc ""
  end

  newproperty(:ftpserver_userisolation_mode, :parent => IisProperty) do
    desc ""
  end

  newproperty(:ftpserver_userisolation_activedirectory_adusername, :parent => IisProperty) do
    desc ""
  end

  newproperty(:ftpserver_userisolation_activedirectory_adpassword, :parent => IisProperty) do
    desc ""
  end

  newproperty(:ftpserver_userisolation_activedirectory_adcacherefresh, :parent => IisProperty) do
    desc ""
  end

  newproperty(:ftpserver_directorybrowse_showflags, :parent => IisProperty) do
    desc ""
  end

  newproperty(:ftpserver_directorybrowse_virtualdirectorytimeout, :parent => IisProperty) do
    desc ""
  end

  newproperty(:ftpserver_logfile_logextfileflags, :parent => IisProperty) do
    desc ""
  end

  newproperty(:ftpserver_logfile_directory, :parent => IisProperty) do
    desc ""
  end

  newproperty(:ftpserver_logfile_period, :parent => IisProperty) do
    desc ""
  end

  newproperty(:ftpserver_logfile_truncatesize, :parent => IisProperty) do
    desc ""
  end

  newproperty(:ftpserver_logfile_localtimerollover, :parent => IisProperty) do
    desc ""
  end

  newproperty(:ftpserver_logfile_enabled, :parent => IisProperty) do
    desc ""
  end

  newproperty(:ftpserver_logfile_selectivelogging, :parent => IisProperty) do
    desc ""
  end

  newproperty(:bindings, :array_matching => :all) do
    desc ""
  end
end
