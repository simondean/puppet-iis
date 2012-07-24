Feature: IIS App Pools
  In order to automate the configuration of IIS
  As an ops practitioner
  I want to use Puppet to manage IIS app pools

  Scenario: No changes when present
    Given an "apppool" called "PuppetTest"
    And its "autostart" property is set to "true"
    And its "processmodel_identitytype" property is set to "ApplicationPoolIdentity"
    Given the manifest
    """
      iis_apppool {'PuppetTest':
        ensure                    => present,
        autostart                 => true,
        processmodel_identitytype => 'ApplicationPoolIdentity',
      }
      """
    When puppet applies the manifest
    Then puppet has not made changes
    And puppet has not changed the "PuppetTest" "apppool"
    And puppet has left its "@autoStart" property set to "true"
    And puppet has left its "processModel/@identityType" property set to "ApplicationPoolIdentity"

  Scenario: No changes when absent
    Given no "apppool" called "PuppetTest"
    Given the manifest
    """
      iis_apppool {'PuppetTest':
        ensure => absent,
      }
      """
    When puppet applies the manifest
    Then puppet has not made changes
    And puppet has not created the "PuppetTest" "apppool"

  Scenario: Create an app pool
    Given no "apppool" called "PuppetTest"
    Given the manifest
    """
      iis_apppool {'PuppetTest':
        ensure => present,
      }
      """
    When puppet applies the manifest
    Then puppet has made changes
    And puppet has created the "PuppetTest" "apppool"

  Scenario: Create an app pool with properties
    Given no "apppool" called "PuppetTest"
    Given the manifest
    """
      iis_apppool {'PuppetTest':
        ensure                    => present,
        autostart                 => false,
        processmodel_identitytype => 'NetworkService',
      }
      """
    When puppet applies the manifest
    Then puppet has made changes
    And puppet has created the "PuppetTest" "apppool"
    And puppet has set its "@autoStart" property to "false"
    And puppet has set its "processModel/@identityType" property to "NetworkService"

  Scenario: Delete an app pool
    Given an "apppool" called "PuppetTest"
    Given the manifest
    """
      iis_apppool {'PuppetTest':
        ensure => absent,
      }
      """
    When puppet applies the manifest
    Then puppet has made changes
    And puppet has deleted the "PuppetTest" "apppool"

  Scenario: Reconfigure an app pool
    Given an "apppool" called "PuppetTest"
    And its "autostart" property is set to "true"
    And its "processmodel_identitytype" property is set to "ApplicationPoolIdentity"
    Given the manifest
    """
      iis_apppool {'PuppetTest':
        ensure                    => present,
        autostart                 => false,
        processmodel_identitytype => 'NetworkService',
      }
      """
    When puppet applies the manifest
    Then puppet has made changes
    And puppet has changed the "PuppetTest" "apppool"
    And puppet has set its "@autoStart" property to "false"
    And puppet has set its "processModel/@identityType" property to "NetworkService"
