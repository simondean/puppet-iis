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
    When the manifest is applied
    Then changes were applied
    Then the "PuppetTest" app pool exists

  Scenario: Delete an app pool
    Given an app pool called "PuppetTest"
    Given the manifest
    """
      iis_apppool {"PuppetTest":
        ensure => absent,
      }
      """
    When the manifest is applied
    Then changes were applied
    Then the "PuppetTest" app pool does not exists