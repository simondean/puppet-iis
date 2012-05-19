Feature: App pools
  In order to manage IIS app pools
  As an ops practitioner
  I want to manage IIS app pools

  Scenario: No changes
    Given an app pool called "PuppetTest"
    And its "autostart" property is set to "true"
    And its "processmodel_identitytype" property is set to "ApplicationPoolIdentity"
    Given the manifest
    """
      iis_apppool {'PuppetTest':
        ensure                    => present,
        autostart                 => true,
        processmodel_identitytype => 'ApplicationPoolIdentity'
      }
      """
    When puppet applies the manifest
    Then puppet has not made changes
    And puppet has changed the "PuppetTest" app pool
    And puppet has set its "autostart" property to "true"
    And puppet has set its "processmodel_identitytype" property to "ApplicationPoolIdentity"

  Scenario: Create an app pool
    Given no app pool called "PuppetTest"
    Given the manifest
    """
      iis_apppool {'PuppetTest':
        ensure => present,
      }
      """
    When puppet applies the manifest
    Then puppet has made changes
    And puppet has created the "PuppetTest" app pool

  Scenario: Delete an app pool
    Given an app pool called "PuppetTest"
    Given the manifest
    """
      iis_apppool {'PuppetTest':
        ensure => absent,
      }
      """
    When puppet applies the manifest
    Then puppet has made changes
    And puppet has deleted the "PuppetTest" app pool

  Scenario: Reconfigure an app pool
    Given an app pool called "PuppetTest"
    And its "autostart" property is set to "false"
    And its "processmodel_identitytype" property is set to "NetworkService"
    Given the manifest
    """
      iis_apppool {'PuppetTest':
        ensure                    => present,
        autostart                 => true,
        processmodel_identitytype => 'ApplicationPoolIdentity'
      }
      """
    When puppet applies the manifest
    Then puppet has made changes
    And puppet has changed the "PuppetTest" app pool
    And puppet has set its "autostart" property to "true"
    And puppet has set its "processmodel_identitytype" property to "ApplicationPoolIdentity"
