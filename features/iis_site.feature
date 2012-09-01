Feature: IIS Sites
  In order to automate the configuration of IIS
  As an ops practitioner
  I want to use Puppet to manage IIS sites

  Background:
    Given an apppool called "Puppet Test"
    Given a directory called "C:\puppet test log"
    Given a directory called "C:\puppet test failed request log"

  Scenario: No changes when present
    Given a site called "Puppet Test"
    And its "serverautostart" property is set to "true"
    And its "limits_maxbandwidth" property is set to "4294967295"
    Given the manifest
    """
      iis_site {'Puppet Test':
        ensure               => present,
        serverautostart      => true,
		limits_maxbandwidth  => 4294967295,
      }
      """
    When puppet applies the manifest
    Then puppet has not made changes
    And puppet has not changed the "Puppet Test" site
    And puppet has left its "@serverAutoStart" property set to "true"
    And puppet has left its "limits/@maxBandwidth" property set to "4294967295"

  Scenario: No changes when absent
    Given no site called "Puppet Test"
    Given the manifest
    """
      iis_site {'Puppet Test':
        ensure => absent,
      }
      """
    When puppet applies the manifest
    Then puppet has not made changes
    And puppet has not created the "Puppet Test" site

  Scenario: Create
    Given no site called "Puppet Test"
    Given the manifest
    """
      iis_site {'Puppet Test':
        ensure => present,
      }
      """
    When puppet applies the manifest
    Then puppet has made changes
    And puppet has created the "Puppet Test" site

  Scenario: Create with properties
    Given no site called "Puppet Test"
    Given the manifest
    """
      iis_site {'Puppet Test':
        ensure                                          => present,
        id                                              => 3737652,
        bindings                                        => ["http/*:25777:", "http/*:25888:"],
        serverautostart                                 => false,
        limits_maxbandwidth                             => 1024,
        limits_maxconnections                           => 1024,
        limits_connectiontimeout                        => '00:00:59',
        logfile_logextfileflags                         => 'BytesRecv, BytesSent',
        logfile_customlogpluginclsid                    => nil,
        logfile_logformat                               => W3C,
        logfile_directory                               => 'C:\puppet test log',
        logfile_period                                  => Daily,
        logfile_truncatesize                            => 2000000,
        logfile_localtimerollover                       => false,
        logfile_enabled                                 => true,
        tracefailedrequestslogging_enabled              => true,
        tracefailedrequestslogging_directory            => 'C:\puppet test failed request log',
        tracefailedrequestslogging_maxlogfilesizekb     => 1000,
        tracefailedrequestslogging_customactionsenabled => true,
        applicationdefaults_path                        => '/',
        applicationdefaults_applicationpool             => 'Puppet Test',
        applicationdefaults_enabledprotocols            => http,
        applicationdefaults_serviceautostartenabled     => false,
        applicationdefaults_serviceautostartprovider    => '',
        virtualdirectorydefaults_path                   => '/',
        virtualdirectorydefaults_physicalpath           => 'C:\puppet test',
        virtualdirectorydefaults_username               => '',
        virtualdirectorydefaults_password               => '',
        virtualdirectorydefaults_logonmethod            => 'ClearText',
        virtualdirectorydefaults_allowsubdirconfig      => true,
      }
      """
    When puppet applies the manifest
    Then puppet has made changes
    And puppet has created the "Puppet Test" site
    And puppet has set its "@id" property to "3737652"
    And puppet has set its "bindings/binding[1]/@protocol" property to "http"
    And puppet has set its "bindings/binding[1]/@bindingInformation" property to "*:25777:"
    And puppet has set its "bindings/binding[2]/@protocol" property to "http"
    And puppet has set its "bindings/binding[2]/@bindingInformation" property to "*:25888:"
    And puppet has set its "@serverAutoStart" property to "false"
    And puppet has set its "limits/@maxBandwidth" property to "1024"
    And puppet has set its "limits/@maxConnections" property to "1024"
    And puppet has set its "limits/@connectionTimeout" property to "00:00:59"
    And puppet has set its "logFile/@logExtFileFlags" property to "BytesSent, BytesRecv"
    And puppet has set its "logFile/@customLogPluginClsid" property to "nil"
    And puppet has set its "logFile/@logFormat" property to "W3C"
    And puppet has set its "logFile/@directory" property to "C:\puppet test log"
    And puppet has set its "logFile/@period" property to "Daily"
    And puppet has set its "logFile/@truncateSize" property to "2000000"
    And puppet has set its "logFile/@localTimeRollover" property to "false"
    And puppet has set its "logFile/@enabled" property to "true"
    And puppet has set its "traceFailedRequestsLogging/@enabled" property to "true"
    And puppet has set its "traceFailedRequestsLogging/@directory" property to "C:\puppet test failed request log"
    And puppet has set its "traceFailedRequestsLogging/@maxLogFileSizeKB" property to "1000"
    And puppet has set its "traceFailedRequestsLogging/@customActionsEnabled" property to "true"
    And puppet has set its "applicationDefaults/@path" property to "/"
    And puppet has set its "applicationDefaults/@applicationPool" property to "Puppet Test"
    And puppet has set its "applicationDefaults/@enabledProtocols" property to "http"
    And puppet has set its "applicationDefaults/@serviceAutoStartEnabled" property to "false"
    And puppet has set its "applicationDefaults/@serviceAutoStartProvider" property to ""
    And puppet has set its "virtualDirectoryDefaults/@path" property to "/"
    And puppet has set its "virtualDirectoryDefaults/@physicalPath" property to "C:\puppet test"
    And puppet has set its "virtualDirectoryDefaults/@userName" property to ""
    And puppet has set its "virtualDirectoryDefaults/@password" property to ""
    And puppet has set its "virtualDirectoryDefaults/@logonMethod" property to "ClearText"
    And puppet has set its "virtualDirectoryDefaults/@allowSubDirConfig" property to "true"

  Scenario: Delete
    Given a site called "Puppet Test"
    Given the manifest
    """
      iis_site {'Puppet Test':
        ensure => absent,
      }
      """
    When puppet applies the manifest
    Then puppet has made changes
    And puppet has deleted the "Puppet Test" site

  Scenario: Reconfigure
    Given a site called "Puppet Test"
    And its "serverautostart" property is set to "true"
    And its "limits_maxbandwidth" property is set to "4294967295"
    Given the manifest
    """
      iis_site {'Puppet Test':
        ensure              => present,
        serverautostart     => false,
        limits_maxbandwidth => 1024,
      }
      """
    When puppet applies the manifest
    Then puppet has made changes
    And puppet has changed the "Puppet Test" site
    And puppet has set its "@serverAutoStart" property to "false"
    And puppet has set its "limits/@maxBandwidth" property to "1024"

  Scenario: Adding a binding
    Given a site called "Puppet Test"
    And it has the property "/+bindings.[protocol='http',bindingInformation='*:25777:']"
    Given the manifest
    """
      iis_site {'Puppet Test':
        ensure              => present,
        bindings            => ["http/*:25777:", "http/*:25888:"],
      }
      """
    When puppet applies the manifest
    Then puppet has made changes
    And puppet has changed the "Puppet Test" site
    And puppet has set its "bindings/binding[1]/@protocol" property to "http"
    And puppet has set its "bindings/binding[1]/@bindingInformation" property to "*:25777:"
    And puppet has set its "bindings/binding[2]/@protocol" property to "http"
    And puppet has set its "bindings/binding[2]/@bindingInformation" property to "*:25888:"

  Scenario: Removing a binding
    Given a site called "Puppet Test"
    And it has the property "/+bindings.[protocol='http',bindingInformation='*:25777:']"
    And it has the property "/+bindings.[protocol='http',bindingInformation='*:25888:']"
    Given the manifest
    """
      iis_site {'Puppet Test':
        ensure              => present,
        bindings            => ["http/*:25777:"],
      }
      """
    When puppet applies the manifest
    Then puppet has made changes
    And puppet has changed the "Puppet Test" site
    And puppet has set its "bindings/binding[1]/@protocol" property to "http"
    And puppet has set its "bindings/binding[1]/@bindingInformation" property to "*:25777:"
    And puppet has unset its "bindings/binding[2]/@protocol" property
    And puppet has unset its "bindings/binding[2]/@bindingInformation" property

  Scenario: No change to bindings
    Given a site called "Puppet Test"
    And it has the property "/+bindings.[protocol='http',bindingInformation='*:25777:']"
    And it has the property "/+bindings.[protocol='http',bindingInformation='*:25888:']"
    Given the manifest
    """
      iis_site {'Puppet Test':
        ensure              => present,
        bindings            => ["http/*:25777:", "http/*:25888:"],
      }
      """
    When puppet applies the manifest
    Then puppet has not made changes
    And puppet has changed the "Puppet Test" site
    And puppet has set its "bindings/binding[1]/@protocol" property to "http"
    And puppet has set its "bindings/binding[1]/@bindingInformation" property to "*:25777:"
    And puppet has set its "bindings/binding[2]/@protocol" property to "http"
    And puppet has set its "bindings/binding[2]/@bindingInformation" property to "*:25888:"
