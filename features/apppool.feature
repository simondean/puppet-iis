Feature: App pools
  In order to manage IIS app pools
  As an ops practitioner
  I want to manage IIS app pools

  Scenario: Create an app pool
    Given no app pool called "PuppetTest"
    Given the manifest
    """
      iis_apppool {"PuppetTest":
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
      iis_apppool {"PuppetTest":
        ensure => absent,
      }
      """
    When puppet applies the manifest
    Then puppet has made changes
    And puppet has deleted the "PuppetTest" app pool

  Scenario: Reconfigure an app pool
    Given an app pool called "PuppetTest"
    And its "autostart" property is set to "false"
    Given the manifest
    """
      iis_apppool {"PuppetTest":
        ensure => present,
        autostart => true
      }
      """
    When puppet applies the manifest
    Then puppet has made changes
    And puppet has changed the "PuppetTest" app pool
    And puppet has set its "autostart" property to "true"
