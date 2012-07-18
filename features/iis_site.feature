Feature: IIS Sites
  In order to manage IIS sites
  As an ops practitioner
  I want to manage IIS sites

  Scenario: No changes when present
    Given a "site" called "PuppetTest"
    And its "serverautostart" property is set to "true"
    And its "limits_maxbandwidth" property is set to "4294967295"
    Given the manifest
    """
      iis_site {'PuppetTest':
        ensure               => present,
        serverautostart      => true,
		limits_maxbandwidth  => 4294967295,
      }
      """
    When puppet applies the manifest
    Then puppet has not made changes
    And puppet has not changed the "PuppetTest" "site"
    And puppet has left its "serverautostart" property set to "true"
    And puppet has left its "limits_maxbandwidth" property set to "4294967295"

  Scenario: No changes when absent
    Given no "site" called "PuppetTest"
    Given the manifest
    """
      iis_site {'PuppetTest':
        ensure => absent,
      }
      """
    When puppet applies the manifest
    Then puppet has not made changes
    And puppet has not created the "PuppetTest" "site"

  Scenario: Create a site
    Given no "site" called "PuppetTest"
    Given the manifest
    """
      iis_site {'PuppetTest':
        ensure => present,
      }
      """
    When puppet applies the manifest
    Then puppet has made changes
    And puppet has created the "PuppetTest" "site"

  Scenario: Create a site with properties
    Given no "site" called "PuppetTest"
    Given the manifest
    """
      iis_site {'PuppetTest':
        ensure              => present,
        serverautostart     => false,
        limits_maxbandwidth => 1024,
      }
      """
    When puppet applies the manifest
    Then puppet has made changes
    And puppet has created the "PuppetTest" "site"
    And puppet has set its "serverautostart" property to "false"
    And puppet has set its "limits_maxbandwidth" property to "1024"

  Scenario: Delete a site
    Given a "site" called "PuppetTest"
    Given the manifest
    """
      iis_site {'PuppetTest':
        ensure => absent,
      }
      """
    When puppet applies the manifest
    Then puppet has made changes
    And puppet has deleted the "PuppetTest" "site"

  Scenario: Reconfigure a site
    Given a "site" called "PuppetTest"
    And its "serverautostart" property is set to "true"
    And its "limits_maxbandwidth" property is set to "4294967295"
    Given the manifest
    """
      iis_site {'PuppetTest':
        ensure              => present,
        serverautostart     => false,
        limits_maxbandwidth => 1024,
      }
      """
    When puppet applies the manifest
    Then puppet has made changes
    And puppet has changed the "PuppetTest" "site"
    And puppet has set its "serverautostart" property to "false"
    And puppet has set its "limits_maxbandwidth" property to "1024"
