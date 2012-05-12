Feature: App pools
  In order to manage IIS app pools
  As an ops practitioner
  I want to manage IIS app pools
  
  Scenario: Create an app pool
    Given no app pool called "TestApppool9001"
    Given the manifest
      """
      iis_apppool {"TestApppool9001":
        ensure => present,
      }
      """
    When the manifest is applied
    Then the "TestApppool9001" app pool exists

  Scenario: Delete an app pool
    Given an app pool called "TestApppool9001"
    Given the manifest
    """
      iis_apppool {"TestApppool9002":
        ensure => absent,
      }
      """
    When the manifest is applied
    Then the "TestApppool9002" app pool does not exists