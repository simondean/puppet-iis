Feature: IIS Apps
  In order to automate the configuration of IIS
  As an ops practitioner
  I want to use Puppet to manage IIS apps

  Background:
    Given a "site" called "PuppetTest"
    Given an "apppool" called "PuppetTest"
    Given an "apppool" called "PuppetTest2"
    Given a "directory" called "C:\\puppet_test"
    Given a "directory" called "C:\\puppet_test2"

  Scenario: No changes when present
    Given an "app" called "PuppetTest/"
    And its "applicationpool" property is set to "PuppetTest"
    And its "enabledprotocols" property is set to "http"
    And its "serviceautostartenabled" property is set to "false"
    And its "serviceautostartprovider" property is set to ""
    And its "virtualdirectorydefaults_path" property is set to "/"
    And its "virtualdirectorydefaults_physicalpath" property is set to "C:\\puppet_test"
    And its "virtualdirectorydefaults_username" property is set to ""
    And its "virtualdirectorydefaults_password" property is set to ""
    And its "virtualdirectorydefaults_logonmethod" property is set to "ClearText"
    And its "virtualdirectorydefaults_allowsubdirconfig" property is set to "true"
    Given the manifest
    """
      iis_app {'PuppetTest/':
        ensure                                      => present,
        applicationpool                             => 'PuppetTest',
        enabledprotocols                            => 'http',
        serviceautostartenabled                     => false,
        serviceautostartprovider                    => '',
        virtualdirectorydefaults_path               => '/',
        virtualdirectorydefaults_physicalpath       => 'C:\\puppet_test',
        virtualdirectorydefaults_username           => '',
        virtualdirectorydefaults_password           => '',
        virtualdirectorydefaults_logonmethod        => 'ClearText',
        virtualdirectorydefaults_allowsubdirconfig  => true,
      }
      """
    When puppet applies the manifest
    Then puppet has not made changes
    And puppet has not changed the "PuppetTest/" "app"
    And puppet has left its "@applicationPool" property set to "PuppetTest"
    And puppet has left its "@enabledProtocols" property set to "http"
    And puppet has left its "@serviceAutoStartEnabled" property set to "false"
    And puppet has left its "@serviceAutoStartProvider" property set to ""
    And puppet has left its "virtualDirectoryDefaults/@path" property set to "/"
    And puppet has left its "virtualDirectoryDefaults/@physicalPath" property set to "C:\\puppet_test"
    And puppet has left its "virtualDirectoryDefaults/@userName" property set to ""
    And puppet has left its "virtualDirectoryDefaults/@password" property set to ""
    And puppet has left its "virtualDirectoryDefaults/@logonMethod" property set to "ClearText"
    And puppet has left its "virtualDirectoryDefaults/@allowSubDirConfig" property set to "true"

  Scenario: No changes when absent
    Given no "app" called "PuppetTest/"
    Given the manifest
    """
      iis_app {'PuppetTest/':
        ensure          => absent,
        applicationpool => 'PuppetTest',
      }
      """
    When puppet applies the manifest
    Then puppet has not made changes
    And puppet has not created the "PuppetTest/" "app"

  Scenario: Create an app
    Given no "app" called "PuppetTest/"
    Given the manifest
    """
      iis_app {'PuppetTest/':
        ensure          => present,
        applicationpool => 'PuppetTest',
      }
      """
    When puppet applies the manifest
    Then puppet has made changes
    And puppet has created the "PuppetTest/" "app"

  Scenario: Create an app with properties
    Given no "app" called "PuppetTest/"
    Given the manifest
    """
      iis_app {'PuppetTest/':
        ensure                                      => present,
        applicationpool                             => 'PuppetTest',
        enabledprotocols                            => 'http',
        serviceautostartenabled                     => false,
        serviceautostartprovider                    => '',
        virtualdirectorydefaults_path               => '/',
        virtualdirectorydefaults_physicalpath       => 'C:\\puppet_test',
        virtualdirectorydefaults_username           => '',
        virtualdirectorydefaults_password           => '',
        virtualdirectorydefaults_logonmethod        => 'ClearText',
        virtualdirectorydefaults_allowsubdirconfig  => true,
      }
      """
    When puppet applies the manifest
    Then puppet has made changes
    And puppet has created the "PuppetTest/" "app"
    And puppet has set its "@applicationPool" property to "PuppetTest"
    And puppet has set its "@enabledProtocols" property to "http"
    And puppet has set its "@serviceAutoStartEnabled" property to "false"
    And puppet has set its "@serviceAutoStartProvider" property to ""
    And puppet has set its "virtualDirectoryDefaults/@path" property to "/"
    And puppet has set its "virtualDirectoryDefaults/@physicalPath" property to "C:\\puppet_test"
    And puppet has set its "virtualDirectoryDefaults/@userName" property to ""
    And puppet has set its "virtualDirectoryDefaults/@password" property to ""
    And puppet has set its "virtualDirectoryDefaults/@logonMethod" property to "ClearText"
    And puppet has set its "virtualDirectoryDefaults/@allowSubDirConfig" property to "true"

  Scenario: Delete an app
    Given an "app" called "PuppetTest/"
    Given the manifest
    """
      iis_app {'PuppetTest/':
        ensure          => absent,
        applicationpool => 'PuppetTest',
      }
      """
    When puppet applies the manifest
    Then puppet has made changes
    And puppet has deleted the "PuppetTest/" "app"

  Scenario: Reconfigure an app
    Given an "app" called "PuppetTest/"
    And its "applicationpool" property is set to "PuppetTest2"
    And its "enabledprotocols" property is set to "https"
    And its "serviceautostartenabled" property is set to "true"
    And its "serviceautostartprovider" property is set to ""
    And its "virtualdirectorydefaults_path" property is set to "/PuppetTest"
    And its "virtualdirectorydefaults_physicalpath" property is set to "C:\\puppet_test2"
    And its "virtualdirectorydefaults_username" property is set to ""
    And its "virtualdirectorydefaults_password" property is set to ""
    And its "virtualdirectorydefaults_logonmethod" property is set to "Batch"
    And its "virtualdirectorydefaults_allowsubdirconfig" property is set to "false"
    Given the manifest
    """
      iis_app {'PuppetTest/':
        ensure                                      => present,
        applicationpool                             => 'PuppetTest',
        enabledprotocols                            => 'http',
        serviceautostartenabled                     => false,
        serviceautostartprovider                    => '',
        virtualdirectorydefaults_path               => '/',
        virtualdirectorydefaults_physicalpath       => 'C:\\puppet_test',
        virtualdirectorydefaults_username           => '',
        virtualdirectorydefaults_password           => '',
        virtualdirectorydefaults_logonmethod        => 'ClearText',
        virtualdirectorydefaults_allowsubdirconfig  => true,
      }
      """
    When puppet applies the manifest
    Then puppet has made changes
    And puppet has changed the "PuppetTest/" "app"
    And puppet has set its "@applicationPool" property to "PuppetTest"
    And puppet has set its "@enabledProtocols" property to "http"
    And puppet has set its "@serviceAutoStartEnabled" property to "false"
    And puppet has set its "@serviceAutoStartProvider" property to ""
    And puppet has set its "virtualDirectoryDefaults/@path" property to "/"
    And puppet has set its "virtualDirectoryDefaults/@physicalPath" property to "C:\\puppet_test"
    And puppet has set its "virtualDirectoryDefaults/@userName" property to ""
    And puppet has set its "virtualDirectoryDefaults/@password" property to ""
    And puppet has set its "virtualDirectoryDefaults/@logonMethod" property to "ClearText"
    And puppet has set its "virtualDirectoryDefaults/@allowSubDirConfig" property to "true"
