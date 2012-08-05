Feature: IIS All Together
  In order to automate the configuration of IIS
  As an ops practitioner
  I want to use Puppet to manage IIS

  Scenario: Creating
    Given no "apppool" called "PuppetTest"
    Given no "site" called "PuppetTest"
    Given no "app" called "PuppetTest/"
    Given no "vdir" called "PuppetTest/"
    Given the manifest
    """
      iis_apppool {'PuppetTest':
        ensure          => present,
      }

      iis_site {'PuppetTest':
        ensure          => present,
      }

      iis_app {'PuppetTest/':
        ensure          => present,
        applicationpool => 'PuppetTest',
      }

      iis_vdir {'PuppetTest/':
        ensure          => present,
        iis_app         => 'PuppetTest/',
      }
      """
    When puppet applies the manifest
    Then puppet has made changes
    And puppet has created the "PuppetTest" "apppool"
    And puppet has created the "PuppetTest" "site"
    And puppet has created the "PuppetTest/" "app"
    And puppet has created the "PuppetTest/" "vdir"

  Scenario: Deleting
    Given an "apppool" called "PuppetTest"
    Given a "site" called "PuppetTest"
    Given an "app" called "PuppetTest/"
    Given a "vdir" called "PuppetTest/" for "PuppetTest/" "app"
    Given the manifest
    """
      iis_apppool {'PuppetTest':
        ensure          => absent,
      }

      iis_site {'PuppetTest':
        ensure          => absent,
      }

      iis_app {'PuppetTest/':
        ensure          => absent,
        applicationpool => 'PuppetTest',
      }

      iis_vdir {'PuppetTest/':
        ensure          => absent,
        iis_app         => 'PuppetTest/',
      }
      """
    When puppet applies the manifest
    Then puppet has made changes
    And puppet has deleted the "PuppetTest" "apppool"
    And puppet has deleted the "PuppetTest" "site"
    And puppet has deleted the "PuppetTest/" "app"
    And puppet has deleted the "PuppetTest/" "vdir"
