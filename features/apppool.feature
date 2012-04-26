Feature: App pools
  In order to manage IIS app pools
  As an ops practitioner
  I want to manage IIS app pools
  
  Scenario: Create an app pool
    Given there is no app pool named "TestApppool26200"
    Given the manifest
      """
      iis_apppool {"TestApppool26200":
        ensure => present,
      }
      """
    When the manifest is applied
    Then there is an app pool named "TestApppool26200"