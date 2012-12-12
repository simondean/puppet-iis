require File.join(File.dirname(__FILE__), 'iis/iis_file_system_path_property')

Puppet::Type.newtype(:iis_site) do
  @doc = "IIS Site"

  ensurable

  newparam(:name) do
    desc "Site name"
  end

  newproperty(:id, :parent => Puppet::IisProperty) do
    desc "Number assigned to a site when it is created. Default Web Site has an id of 1. Other sites are assigned a random id by IIS when they are created"
  end

  newproperty(:serverautostart, :parent => Puppet::IisProperty) do
    desc "Whether the site should be started automatically when the IIS management service is started"
  end

  newproperty(:limits_maxbandwidth, :parent => Puppet::IisProperty) do
    desc "Limits: Maximum network bandwidth in bytes per second to be consumed by the site"
  end

  newproperty(:limits_maxconnections, :parent => Puppet::IisProperty) do
    desc "Limits: Maximum number of simultaneous client connections for a site"
  end

  newproperty(:limits_connectiontimeout, :parent => Puppet::IisProperty) do
    desc "Limits: The amount of time in seconds that IIS waits before disconnecting a connection that has become inactive"
  end

  newproperty(:logfile_logextfileflags, :parent => Puppet::IisProperty) do
    desc "Logging: The categories of information that are logged"
  end

  newproperty(:logfile_customlogpluginclsid, :parent => Puppet::IisProperty) do
    desc "Logging: COM object class IDs for custom modules"
  end

  newproperty(:logfile_logformat, :parent => Puppet::IisProperty) do
    desc "Logging: Log file format"
  end

  newproperty(:logfile_directory, :parent => Puppet::IisFileSystemPathProperty) do
    desc "Logging: Directory that log files and supporting logging files are saved to"
  end

  newproperty(:logfile_period, :parent => Puppet::IisProperty) do
    desc "Logging: "
  end

  newproperty(:logfile_truncatesize, :parent => Puppet::IisProperty) do
    desc "Logging: Maximum size in bytes for the log file. When reached, a new log file will be created. Only applies when logfile_period is set to MaxSize.  Minimum value for this property is 1,048,576"
  end

  newproperty(:logfile_localtimerollover, :parent => Puppet::IisProperty) do
    desc "Logging: Whether when a new log file is created based on time, this is done based on UTC or local time.  false indicates UTC, true indicates local time"
  end

  newproperty(:logfile_enabled, :parent => Puppet::IisProperty) do
    desc "Logging: Whether logging is enabled"
  end

  newproperty(:tracefailedrequestslogging_enabled, :parent => Puppet::IisProperty) do
    desc "Trace failed requests logging: Whether it is enabled"
  end

  newproperty(:tracefailedrequestslogging_directory, :parent => Puppet::IisProperty) do
    desc "Trace failed requests logging: Directory that log files are saved to"
  end

  newproperty(:tracefailedrequestslogging_maxlogfiles, :parent => Puppet::IisProperty) do
    desc "Trace failed requests logging: Maximum number of failed request log files to keep for the site"
  end

  newproperty(:tracefailedrequestslogging_maxlogfilesizekb, :parent => Puppet::IisProperty) do
    desc "Trace failed requests logging: Maximum file size in kilobytes for the logs"
  end

  newproperty(:tracefailedrequestslogging_customactionsenabled, :parent => Puppet::IisProperty) do
    desc "Trace failed requests logging: Whether custom actions are enabled"
  end

  newproperty(:applicationdefaults_path, :parent => Puppet::IisProperty) do
    desc "Application defaults: Application virtual path"
  end

  newproperty(:applicationdefaults_applicationpool, :parent => Puppet::IisProperty) do
    desc "Application defaults: Application pool the application is assigned to"
  end

  newproperty(:applicationdefaults_enabledprotocols, :parent => Puppet::IisProperty) do
    desc "Application defaults: Enabled protocols"
  end

  newproperty(:applicationdefaults_serviceautostartenabled, :parent => Puppet::IisProperty) do
    desc "Application defaults: Whether autostart is enabled"
  end

  newproperty(:applicationdefaults_serviceautostartprovider, :parent => Puppet::IisProperty) do
    desc "Application defaults: Name of the autostart provider, if enabled"
  end

  newproperty(:virtualdirectorydefaults_path, :parent => Puppet::IisProperty) do
    desc "Virtual directory defaults: Virtual directory virtual path"
  end

  newproperty(:virtualdirectorydefaults_physicalpath, :parent => Puppet::IisProperty) do
    desc "Virtual directory defaults: Physical path"
  end

  newproperty(:virtualdirectorydefaults_logonmethod, :parent => Puppet::IisProperty) do
    desc "Virtual directory defaults: Logon method for the physical path"
  end

  newproperty(:virtualdirectorydefaults_username, :parent => Puppet::IisProperty) do
    desc "Virtual directory defaults: User name that can access the physical path"
  end

  newproperty(:virtualdirectorydefaults_password, :parent => Puppet::IisProperty) do
    desc "Virtual directory defaults: Password for the user name"
  end

  newproperty(:virtualdirectorydefaults_allowsubdirconfig, :parent => Puppet::IisProperty) do
    desc "Virtual directory defaults: Controls whether IIS will load just the Web.config file in the physical path (false) or also the Web.config files in the sub-directories of the physical path (true)"
  end

  newproperty(:ftpserver_allowutf8, :parent => Puppet::IisProperty) do
    desc ""
  end

  newproperty(:ftpserver_serverautostart, :parent => Puppet::IisProperty) do
    desc ""
  end

  newproperty(:ftpserver_connections_unauthenticatedtimeout, :parent => Puppet::IisProperty) do
    desc ""
  end

  newproperty(:ftpserver_connections_controlchanneltimeout, :parent => Puppet::IisProperty) do
    desc ""
  end

  newproperty(:ftpserver_connections_datachanneltimeout, :parent => Puppet::IisProperty) do
    desc ""
  end

  newproperty(:ftpserver_connections_disablesocketpooling, :parent => Puppet::IisProperty) do
    desc ""
  end

  newproperty(:ftpserver_connections_serverlistenbacklog, :parent => Puppet::IisProperty) do
    desc ""
  end

  newproperty(:ftpserver_connections_minbytespersecond, :parent => Puppet::IisProperty) do
    desc ""
  end

  newproperty(:ftpserver_connections_maxconnections, :parent => Puppet::IisProperty) do
    desc ""
  end

  newproperty(:ftpserver_connections_resetonmaxconnections, :parent => Puppet::IisProperty) do
    desc ""
  end

  newproperty(:ftpserver_connections_maxbandwidth, :parent => Puppet::IisProperty) do
    desc ""
  end

  newproperty(:ftpserver_security_datachannelsecurity_matchclientaddressforport, :parent => Puppet::IisProperty) do
    desc ""
  end

  newproperty(:ftpserver_security_datachannelsecurity_matchclientaddressforpasv, :parent => Puppet::IisProperty) do
    desc ""
  end

  newproperty(:ftpserver_security_commandfiltering_maxcommandline, :parent => Puppet::IisProperty) do
    desc ""
  end

  newproperty(:ftpserver_security_commandfiltering_allowunlisted, :parent => Puppet::IisProperty) do
    desc ""
  end

  newproperty(:ftpserver_security_ssl_servercerthash, :parent => Puppet::IisProperty) do
    desc ""
  end

  newproperty(:ftpserver_security_ssl_servercertstorename, :parent => Puppet::IisProperty) do
    desc ""
  end

  newproperty(:ftpserver_security_ssl_ssl128, :parent => Puppet::IisProperty) do
    desc ""
  end

  newproperty(:ftpserver_security_ssl_controlchannelpolicy, :parent => Puppet::IisProperty) do
    desc ""
  end

  newproperty(:ftpserver_security_ssl_datachannelpolicy, :parent => Puppet::IisProperty) do
    desc ""
  end

  newproperty(:ftpserver_security_sslclientcertificates_clientcertificatepolicy, :parent => Puppet::IisProperty) do
    desc ""
  end

  newproperty(:ftpserver_security_sslclientcertificates_useactivedirectorymapping, :parent => Puppet::IisProperty) do
    desc ""
  end

  newproperty(:ftpserver_security_sslclientcertificates_validationflags, :parent => Puppet::IisProperty) do
    desc ""
  end

  newproperty(:ftpserver_security_sslclientcertificates_revocationfreshnesstime, :parent => Puppet::IisProperty) do
    desc ""
  end

  newproperty(:ftpserver_security_sslclientcertificates_revocationurlretrievaltimeout, :parent => Puppet::IisProperty) do
    desc ""
  end

  newproperty(:ftpserver_security_authentication_anonymousauthentication_enabled, :parent => Puppet::IisProperty) do
    desc ""
  end

  newproperty(:ftpserver_security_authentication_anonymousauthentication_username, :parent => Puppet::IisProperty) do
    desc ""
  end

  newproperty(:ftpserver_security_authentication_anonymousauthentication_password, :parent => Puppet::IisProperty) do
    desc ""
  end

  newproperty(:ftpserver_security_authentication_anonymousauthentication_defaultlogondomain, :parent => Puppet::IisProperty) do
    desc ""
  end

  newproperty(:ftpserver_security_authentication_anonymousauthentication_logonmethod, :parent => Puppet::IisProperty) do
    desc ""
  end

  newproperty(:ftpserver_security_authentication_basicauthentication_enabled, :parent => Puppet::IisProperty) do
    desc ""
  end

  newproperty(:ftpserver_security_authentication_basicauthentication_defaultlogondomain, :parent => Puppet::IisProperty) do
    desc ""
  end

  newproperty(:ftpserver_security_authentication_basicauthentication_logonmethod, :parent => Puppet::IisProperty) do
    desc ""
  end

  newproperty(:ftpserver_security_authentication_clientcertauthentication_enabled, :parent => Puppet::IisProperty) do
    desc ""
  end

  newproperty(:ftpserver_messages_exitmessage, :parent => Puppet::IisProperty) do
    desc ""
  end

  newproperty(:ftpserver_messages_greetingmessage, :parent => Puppet::IisProperty) do
    desc ""
  end

  newproperty(:ftpserver_messages_bannermessage, :parent => Puppet::IisProperty) do
    desc ""
  end

  newproperty(:ftpserver_messages_maxclientsmessage, :parent => Puppet::IisProperty) do
    desc ""
  end

  newproperty(:ftpserver_messages_suppressdefaultbanner, :parent => Puppet::IisProperty) do
    desc ""
  end

  newproperty(:ftpserver_messages_allowlocaldetailederrors, :parent => Puppet::IisProperty) do
    desc ""
  end

  newproperty(:ftpserver_messages_expandvariables, :parent => Puppet::IisProperty) do
    desc ""
  end

  newproperty(:ftpserver_filehandling_keeppartialuploads, :parent => Puppet::IisProperty) do
    desc ""
  end

  newproperty(:ftpserver_filehandling_allowreplaceonrename, :parent => Puppet::IisProperty) do
    desc ""
  end

  newproperty(:ftpserver_filehandling_allowreaduploadsinprogress, :parent => Puppet::IisProperty) do
    desc ""
  end

  newproperty(:ftpserver_firewallsupport_externalip4address, :parent => Puppet::IisProperty) do
    desc ""
  end

  newproperty(:ftpserver_userisolation_mode, :parent => Puppet::IisProperty) do
    desc ""
  end

  newproperty(:ftpserver_userisolation_activedirectory_adusername, :parent => Puppet::IisProperty) do
    desc ""
  end

  newproperty(:ftpserver_userisolation_activedirectory_adpassword, :parent => Puppet::IisProperty) do
    desc ""
  end

  newproperty(:ftpserver_userisolation_activedirectory_adcacherefresh, :parent => Puppet::IisProperty) do
    desc ""
  end

  newproperty(:ftpserver_directorybrowse_showflags, :parent => Puppet::IisProperty) do
    desc ""
  end

  newproperty(:ftpserver_directorybrowse_virtualdirectorytimeout, :parent => Puppet::IisProperty) do
    desc ""
  end

  newproperty(:ftpserver_logfile_logextfileflags, :parent => Puppet::IisProperty) do
    desc ""
  end

  newproperty(:ftpserver_logfile_directory, :parent => Puppet::IisProperty) do
    desc ""
  end

  newproperty(:ftpserver_logfile_period, :parent => Puppet::IisProperty) do
    desc ""
  end

  newproperty(:ftpserver_logfile_truncatesize, :parent => Puppet::IisProperty) do
    desc ""
  end

  newproperty(:ftpserver_logfile_localtimerollover, :parent => Puppet::IisProperty) do
    desc ""
  end

  newproperty(:ftpserver_logfile_enabled, :parent => Puppet::IisProperty) do
    desc ""
  end

  newproperty(:ftpserver_logfile_selectivelogging, :parent => Puppet::IisProperty) do
    desc ""
  end

  newproperty(:bindings, :array_matching => :all) do
    desc ""
  end
end
