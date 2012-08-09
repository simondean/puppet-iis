Feature: IIS Virtual Directories
  In order to automate the configuration of IIS
  As an ops practitioner
  I want to use Puppet to manage IIS virtual directories

  Background:
    Given a "site" called "PuppetTest"
    Given an "apppool" called "PuppetTest"
    Given an "apppool" called "PuppetTest2"
    Given a "directory" called "C:\puppet_test"
    Given a "directory" called "C:\puppet_test2"
    Given an "app" called "PuppetTest/"

  Scenario: No changes when present
    Given a "vdir" called "PuppetTest/" for "PuppetTest/" "app"
    And its "physicalpath" property is set to "C:\puppet_test"
    And its "username" property is set to ""
    And its "password" property is set to ""
    And its "logonmethod" property is set to "ClearText"
    And its "allowsubdirconfig" property is set to "true"
    Given the manifest
    """
      iis_vdir {'PuppetTest/':
        ensure            => present,
        iis_app           => 'PuppetTest/',
        physicalpath      => 'C:\puppet_test',
        username          => '',
        password          => '',
        logonmethod       => 'ClearText',
        allowsubdirconfig => true,
      }
      """
    When puppet applies the manifest
    Then puppet has not made changes
    And puppet has not changed the "PuppetTest/" "vdir"
    And puppet has left its "@physicalPath" property set to "C:\puppet_test"
    And puppet has left its "@userName" property set to ""
    And puppet has left its "@password" property set to ""
    And puppet has left its "@logonMethod" property set to "ClearText"
    And puppet has left its "@allowSubDirConfig" property set to "true"

  Scenario: No changes when absent
    Given no "vdir" called "PuppetTest/"
    Given the manifest
    """
      iis_vdir {'PuppetTest/':
        ensure  => absent,
        iis_app => 'PuppetTest/',
      }
      """
    When puppet applies the manifest
    Then puppet has not made changes
    And puppet has not created the "PuppetTest/" "vdir"

  Scenario: Create
    Given no "vdir" called "PuppetTest/"
    Given the manifest
    """
      iis_vdir {'PuppetTest/':
        ensure  => present,
        iis_app => 'PuppetTest/',
      }
      """
    When puppet applies the manifest
    Then puppet has made changes
    And puppet has created the "PuppetTest/" "vdir"

  Scenario: Create with properties
    Given no "vdir" called "PuppetTest/"
    Given the manifest
    """
      iis_vdir {'PuppetTest/':
        ensure            => present,
        iis_app           => 'PuppetTest/',
        physicalpath      => 'C:\puppet_test',
        username          => '',
        password          => '',
        logonmethod       => 'ClearText',
        allowsubdirconfig => true,
      }
      """
    When puppet applies the manifest
    Then puppet has made changes
    And puppet has created the "PuppetTest/" "vdir"
    And puppet has set its "@physicalPath" property to "C:\puppet_test"
    And puppet has set its "@userName" property to ""
    And puppet has set its "@password" property to ""
    And puppet has set its "@logonMethod" property to "ClearText"
    And puppet has set its "@allowSubDirConfig" property to "true"

  Scenario: Delete
    Given a "vdir" called "PuppetTest/" for "PuppetTest/" "app"
    Given the manifest
    """
      iis_vdir {'PuppetTest/':
        ensure  => absent,
        iis_app => 'PuppetTest/',
      }
      """
    When puppet applies the manifest
    Then puppet has made changes
    And puppet has deleted the "PuppetTest/" "vdir"

  Scenario: Reconfigure
    Given a "vdir" called "PuppetTest/" for "PuppetTest/" "app"
    And its "physicalpath" property is set to "C:\puppet_test2"
    And its "username" property is set to ""
    And its "password" property is set to ""
    And its "logonmethod" property is set to "Batch"
    And its "allowsubdirconfig" property is set to "false"
    Given the manifest
    """
      iis_vdir {'PuppetTest/':
        ensure            => present,
        iis_app           => 'PuppetTest/',
        physicalpath      => 'C:\puppet_test',
        username          => '',
        password          => '',
        logonmethod       => 'ClearText',
        allowsubdirconfig => true,
      }
      """
    When puppet applies the manifest
    Then puppet has made changes
    And puppet has changed the "PuppetTest/" "vdir"
    And puppet has set its "@physicalPath" property to "C:\puppet_test"
    And puppet has set its "@userName" property to ""
    And puppet has set its "@password" property to ""
    And puppet has set its "@logonMethod" property to "ClearText"
    And puppet has set its "@allowSubDirConfig" property to "true"
