Feature: IIS Bindings
  In order to manage IIS bindings
  As an ops practitioner
  I want to manage IIS bindings

  Scenario: No changes when present
    Given a "site" called "PuppetTest"
    And its "bindings" property is set to "http/*:57300:"
    Given the manifest
    """
      iis_binding {'http/*:57300:':
        ensure => present,
      }
      """
    When puppet applies the manifest
    Then puppet has not made changes
    And puppet has not changed the "PuppetTest" "site"
    And puppet has left its "bindings" property set to "http/*:57300:"

  Scenario: No changes when absent
    Given a "site" called "PuppetTest"
    Given the manifest
    """
      iis_binding {'http/*:57300:':
        ensure => absent,
      }
      """
    When puppet applies the manifest
    Then puppet has not made changes
    And puppet has not changed the "PuppetTest" "site"
    And puppet has left its "bindings" property unset

  Scenario: Create a binding
    Given a "site" called "PuppetTest"
    Given the manifest
    """
      iis_binding {'http/*:57300:':
        ensure => present,
      }
      """
    When puppet applies the manifest
    Then puppet has made changes
    And puppet has changed the "PuppetTest" "site"
    And puppet has set its "bindings" property to "http/*:57300:"

  Scenario: Delete an app pool
    Given a "site" called "PuppetTest"
    And its "bindings" property is set to "http/*:57300:"
    Given the manifest
    """
      iis_binding {'http/*:57300:':
        ensure => absent,
      }
      """
    When puppet applies the manifest
    Then puppet has made changes
    And puppet has changed the "PuppetTest" "site"
    And puppet has unset its "bindings" property
