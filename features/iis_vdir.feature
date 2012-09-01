Feature: IIS Virtual Directories
  In order to automate the configuration of IIS
  As an ops practitioner
  I want to use Puppet to manage IIS virtual directories

  Background:
    Given a site called "Puppet Test"
    Given an apppool called "Puppet Test"
    Given an apppool called "Puppet Test2"
    Given a directory called "C:\puppet_test"
    Given a directory called "C:\puppet_test2"
    Given a directory called "C:\puppet test with spaces"
    Given an app called "Puppet Test/"
    Given an app called "Puppet Test/app"

  Scenario Outline: No changes when present
    Given a vdir called "<iis_vdir>" for "<iis_app>" app
    And its "physicalpath" property is set to "C:\puppet_test"
    And its "username" property is set to ""
    And its "password" property is set to ""
    And its "logonmethod" property is set to "ClearText"
    And its "allowsubdirconfig" property is set to "true"
    Given the manifest
    """
      iis_vdir {'<iis_vdir>':
        ensure            => present,
        iis_app           => '<iis_app>',
        physicalpath      => 'C:\puppet_test',
        username          => '',
        password          => '',
        logonmethod       => 'ClearText',
        allowsubdirconfig => true,
      }
      """
    When puppet applies the manifest
    Then puppet has not made changes
    And puppet has not changed the "<iis_vdir>" vdir
    And puppet has left its "@physicalPath" property set to "C:\puppet_test"
    And puppet has left its "@userName" property set to ""
    And puppet has left its "@password" property set to ""
    And puppet has left its "@logonMethod" property set to "ClearText"
    And puppet has left its "@allowSubDirConfig" property set to "true"

  Examples:
    | iis_app        | iis_vdir        |
    | Puppet Test/    | Puppet Test/     |
    | Puppet Test/app | Puppet Test/app/ |
    | Puppet Test/    | Puppet Test/vdir |

  Examples:
    | iis_app        | iis_vdir        |
    | Puppet Test/    | Puppet Test/     |
    | Puppet Test/app | Puppet Test/app/ |
    | Puppet Test/    | Puppet Test/vdir |

  Scenario Outline: No changes when absent
    Given no vdir called "<iis_vdir>"
    Given the manifest
    """
      iis_vdir {'<iis_vdir>':
        ensure  => absent,
        iis_app => '<iis_app>',
      }
      """
    When puppet applies the manifest
    Then puppet has not made changes
    And puppet has not created the "<iis_vdir>" vdir

  Examples:
    | iis_app        | iis_vdir        |
    | Puppet Test/    | Puppet Test/     |
    | Puppet Test/app | Puppet Test/app/ |
    | Puppet Test/    | Puppet Test/vdir |
    
  Scenario Outline: Create
    Given no vdir called "<iis_vdir>"
    Given the manifest
    """
      iis_vdir {'<iis_vdir>':
        ensure  => present,
        iis_app => '<iis_app>',
      }
      """
    When puppet applies the manifest
    Then puppet has made changes
    And puppet has created the "<iis_vdir>" vdir

  Examples:
    | iis_app        | iis_vdir        |
    | Puppet Test/    | Puppet Test/     |
    | Puppet Test/app | Puppet Test/app/ |
    | Puppet Test/    | Puppet Test/vdir |
    
  Scenario Outline: Create with properties
    Given no vdir called "<iis_vdir>"
    Given the manifest
    """
      iis_vdir {'<iis_vdir>':
        ensure            => present,
        iis_app           => '<iis_app>',
        physicalpath      => 'C:\puppet_test',
        username          => '',
        password          => '',
        logonmethod       => 'ClearText',
        allowsubdirconfig => true,
      }
      """
    When puppet applies the manifest
    Then puppet has made changes
    And puppet has created the "<iis_vdir>" vdir
    And puppet has set its "@physicalPath" property to "C:\puppet_test"
    And puppet has set its "@userName" property to ""
    And puppet has set its "@password" property to ""
    And puppet has set its "@logonMethod" property to "ClearText"
    And puppet has set its "@allowSubDirConfig" property to "true"

  Examples:
    | iis_app        | iis_vdir        |
    | Puppet Test/    | Puppet Test/     |
    | Puppet Test/app | Puppet Test/app/ |
    | Puppet Test/    | Puppet Test/vdir |
    
  Scenario Outline: Create with spaces in physical path
    Given no vdir called "<iis_vdir>"
    Given the manifest
    """
      iis_vdir {'<iis_vdir>':
        ensure            => present,
        iis_app           => '<iis_app>',
        physicalpath      => 'C:\puppet test with spaces',
        username          => '',
        password          => '',
        logonmethod       => 'ClearText',
        allowsubdirconfig => true,
      }
      """
    When puppet applies the manifest
    Then puppet has made changes
    And puppet has created the "<iis_vdir>" vdir
    And puppet has set its "@physicalPath" property to "C:\puppet test with spaces"
    And puppet has set its "@userName" property to ""
    And puppet has set its "@password" property to ""
    And puppet has set its "@logonMethod" property to "ClearText"
    And puppet has set its "@allowSubDirConfig" property to "true"

  Examples:
    | iis_app        | iis_vdir        |
    | Puppet Test/    | Puppet Test/     |
    | Puppet Test/app | Puppet Test/app/ |
    | Puppet Test/    | Puppet Test/vdir |

  Scenario Outline: Delete
    Given a vdir called "<iis_vdir>" for "<iis_app>" app
    Given the manifest
    """
      iis_vdir {'<iis_vdir>':
        ensure  => absent,
        iis_app => '<iis_app>',
      }
      """
    When puppet applies the manifest
    Then puppet has made changes
    And puppet has deleted the "<iis_vdir>" vdir

  Examples:
    | iis_app        | iis_vdir        |
    | Puppet Test/    | Puppet Test/     |
    | Puppet Test/app | Puppet Test/app/ |
    | Puppet Test/    | Puppet Test/vdir |
    
  Scenario Outline: Reconfigure
    Given a vdir called "<iis_vdir>" for "<iis_app>" app
    And its "physicalpath" property is set to "C:\puppet_test2"
    And its "username" property is set to ""
    And its "password" property is set to ""
    And its "logonmethod" property is set to "Batch"
    And its "allowsubdirconfig" property is set to "false"
    Given the manifest
    """
      iis_vdir {'<iis_vdir>':
        ensure            => present,
        iis_app           => '<iis_app>',
        physicalpath      => 'C:\puppet_test',
        username          => '',
        password          => '',
        logonmethod       => 'ClearText',
        allowsubdirconfig => true,
      }
      """
    When puppet applies the manifest
    Then puppet has made changes
    And puppet has changed the "<iis_vdir>" vdir
    And puppet has set its "@physicalPath" property to "C:\puppet_test"
    And puppet has set its "@userName" property to ""
    And puppet has set its "@password" property to ""
    And puppet has set its "@logonMethod" property to "ClearText"
    And puppet has set its "@allowSubDirConfig" property to "true"

  Examples:
    | iis_app        | iis_vdir        |
    | Puppet Test/    | Puppet Test/     |
    | Puppet Test/app | Puppet Test/app/ |
    | Puppet Test/    | Puppet Test/vdir |
    