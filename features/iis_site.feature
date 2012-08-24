Feature: IIS Sites
  In order to automate the configuration of IIS
  As an ops practitioner
  I want to use Puppet to manage IIS sites

  Scenario: No changes when present
    Given a site called "PuppetTest"
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
    And puppet has not changed the "PuppetTest" site
    And puppet has left its "@serverAutoStart" property set to "true"
    And puppet has left its "limits/@maxBandwidth" property set to "4294967295"

  Scenario: No changes when absent
    Given no site called "PuppetTest"
    Given the manifest
    """
      iis_site {'PuppetTest':
        ensure => absent,
      }
      """
    When puppet applies the manifest
    Then puppet has not made changes
    And puppet has not created the "PuppetTest" site

  Scenario: Create
    Given no site called "PuppetTest"
    Given the manifest
    """
      iis_site {'PuppetTest':
        ensure => present,
      }
      """
    When puppet applies the manifest
    Then puppet has made changes
    And puppet has created the "PuppetTest" site

  Scenario: Create with properties
    Given no site called "PuppetTest"
    Given the manifest
    """
      iis_site {'PuppetTest':
        ensure              => present,
        serverautostart     => false,
        limits_maxbandwidth => 1024,
        bindings            => ["http/*:25777:", "http/*:25888:"],
      }
      """
    When puppet applies the manifest
    Then puppet has made changes
    And puppet has created the "PuppetTest" site
    And puppet has set its "@serverAutoStart" property to "false"
    And puppet has set its "limits/@maxBandwidth" property to "1024"
    And puppet has set its "bindings/binding[1]/@protocol" property to "http"
    And puppet has set its "bindings/binding[1]/@bindingInformation" property to "*:25777:"
    And puppet has set its "bindings/binding[2]/@protocol" property to "http"
    And puppet has set its "bindings/binding[2]/@bindingInformation" property to "*:25888:"

  Scenario: Delete
    Given a site called "PuppetTest"
    Given the manifest
    """
      iis_site {'PuppetTest':
        ensure => absent,
      }
      """
    When puppet applies the manifest
    Then puppet has made changes
    And puppet has deleted the "PuppetTest" site

  Scenario: Reconfigure
    Given a site called "PuppetTest"
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
    And puppet has changed the "PuppetTest" site
    And puppet has set its "@serverAutoStart" property to "false"
    And puppet has set its "limits/@maxBandwidth" property to "1024"

  Scenario: Adding a binging
    Given a site called "PuppetTest"
    And it has the property "/+bindings.[protocol='http',bindingInformation='*:25777:']"
    Given the manifest
    """
      iis_site {'PuppetTest':
        ensure              => present,
        bindings            => ["http/*:25777:", "http/*:25888:"],
      }
      """
    When puppet applies the manifest
    Then puppet has made changes
    And puppet has changed the "PuppetTest" site
    And puppet has set its "bindings/binding[1]/@protocol" property to "http"
    And puppet has set its "bindings/binding[1]/@bindingInformation" property to "*:25777:"
    And puppet has set its "bindings/binding[2]/@protocol" property to "http"
    And puppet has set its "bindings/binding[2]/@bindingInformation" property to "*:25888:"

  Scenario: Removing a binging
    Given a site called "PuppetTest"
    And it has the property "/+bindings.[protocol='http',bindingInformation='*:25777:']"
    And it has the property "/+bindings.[protocol='http',bindingInformation='*:25888:']"
    Given the manifest
    """
      iis_site {'PuppetTest':
        ensure              => present,
        bindings            => ["http/*:25777:"],
      }
      """
    When puppet applies the manifest
    Then puppet has made changes
    And puppet has changed the "PuppetTest" site
    And puppet has set its "bindings/binding[1]/@protocol" property to "http"
    And puppet has set its "bindings/binding[1]/@bindingInformation" property to "*:25777:"
    And puppet has unset its "bindings/binding[2]/@protocol" property
    And puppet has unset its "bindings/binding[2]/@bindingInformation" property

  Scenario: No change to bingings
    Given a site called "PuppetTest"
    And it has the property "/+bindings.[protocol='http',bindingInformation='*:25777:']"
    And it has the property "/+bindings.[protocol='http',bindingInformation='*:25888:']"
    Given the manifest
    """
      iis_site {'PuppetTest':
        ensure              => present,
        bindings            => ["http/*:25777:", "http/*:25888:"],
      }
      """
    When puppet applies the manifest
    Then puppet has not made changes
    And puppet has changed the "PuppetTest" site
    And puppet has set its "bindings/binding[1]/@protocol" property to "http"
    And puppet has set its "bindings/binding[1]/@bindingInformation" property to "*:25777:"
    And puppet has set its "bindings/binding[2]/@protocol" property to "http"
    And puppet has set its "bindings/binding[2]/@bindingInformation" property to "*:25888:"
