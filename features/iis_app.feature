Feature: IIS Apps
  In order to automate the configuration of IIS
  As an ops practitioner
  I want to use Puppet to manage IIS apps

  Background:
    Given a site called "Puppet Test"
    Given an apppool called "Puppet Test"
    Given an apppool called "Puppet Test 2"
    Given a directory called "C:\puppet_test"
    Given a directory called "C:\puppet_test2"

  Scenario Outline: No changes when present
    Given an app called "<iis_app>"
    And its "applicationpool" property is set to "Puppet Test"
    And its "enabledprotocols" property is set to "http"
    And its "serviceautostartenabled" property is set to "false"
    And its "serviceautostartprovider" property is set to ""
    And its "virtualdirectorydefaults_path" property is set to "/"
    And its "virtualdirectorydefaults_physicalpath" property is set to "C:\puppet_test"
    And its "virtualdirectorydefaults_username" property is set to ""
    And its "virtualdirectorydefaults_password" property is set to ""
    And its "virtualdirectorydefaults_logonmethod" property is set to "ClearText"
    And its "virtualdirectorydefaults_allowsubdirconfig" property is set to "true"
    Given the manifest
    """
      iis_app {'<iis_app>':
        ensure                                      => present,
        applicationpool                             => 'Puppet Test',
        enabledprotocols                            => 'http',
        serviceautostartenabled                     => false,
        serviceautostartprovider                    => '',
        virtualdirectorydefaults_path               => '/',
        virtualdirectorydefaults_physicalpath       => 'C:\puppet_test',
        virtualdirectorydefaults_username           => '',
        virtualdirectorydefaults_password           => '',
        virtualdirectorydefaults_logonmethod        => 'ClearText',
        virtualdirectorydefaults_allowsubdirconfig  => true,
      }
      """
    When puppet applies the manifest
    Then puppet has not made changes
    And puppet has not changed the "<iis_app>" app
    And puppet has left its "@applicationPool" property set to "Puppet Test"
    And puppet has left its "@enabledProtocols" property set to "http"
    And puppet has left its "@serviceAutoStartEnabled" property set to "false"
    And puppet has left its "@serviceAutoStartProvider" property set to ""
    And puppet has left its "virtualDirectoryDefaults/@path" property set to "/"
    And puppet has left its "virtualDirectoryDefaults/@physicalPath" property set to "C:\puppet_test"
    And puppet has left its "virtualDirectoryDefaults/@userName" property set to ""
    And puppet has left its "virtualDirectoryDefaults/@password" property set to ""
    And puppet has left its "virtualDirectoryDefaults/@logonMethod" property set to "ClearText"
    And puppet has left its "virtualDirectoryDefaults/@allowSubDirConfig" property set to "true"
    
  Examples:
    | iis_app        |
    | Puppet Test/    |
    | Puppet Test/app |

  Examples:
    | iis_app        |
    | Puppet Test/    |
    | Puppet Test/app |

  Scenario Outline: No changes when absent
    Given no app called "<iis_app>"
    Given the manifest
    """
      iis_app {'<iis_app>':
        ensure          => absent,
        applicationpool => 'Puppet Test',
      }
      """
    When puppet applies the manifest
    Then puppet has not made changes
    And puppet has not created the "<iis_app>" app
    
  Examples:
    | iis_app        |
    | Puppet Test/    |
    | Puppet Test/app |

  Scenario Outline: Create
    Given no app called "<iis_app>"
    Given the manifest
    """
      iis_app {'<iis_app>':
        ensure          => present,
        applicationpool => 'Puppet Test',
      }
      """
    When puppet applies the manifest
    Then puppet has made changes
    And puppet has created the "<iis_app>" app
    
  Examples:
    | iis_app        |
    | Puppet Test/    |
    | Puppet Test/app |

  Scenario Outline: Create with properties
    Given no app called "<iis_app>"
    Given the manifest
    """
      iis_app {'<iis_app>':
        ensure                                      => present,
        applicationpool                             => 'Puppet Test',
        enabledprotocols                            => 'http',
        serviceautostartenabled                     => false,
        serviceautostartprovider                    => '',
        virtualdirectorydefaults_path               => '/',
        virtualdirectorydefaults_physicalpath       => 'C:\puppet_test',
        virtualdirectorydefaults_username           => '',
        virtualdirectorydefaults_password           => '',
        virtualdirectorydefaults_logonmethod        => 'ClearText',
        virtualdirectorydefaults_allowsubdirconfig  => true,
      }
      """
    When puppet applies the manifest
    Then puppet has made changes
    And puppet has created the "<iis_app>" app
    And puppet has set its "@applicationPool" property to "Puppet Test"
    And puppet has set its "@enabledProtocols" property to "http"
    And puppet has set its "@serviceAutoStartEnabled" property to "false"
    And puppet has set its "@serviceAutoStartProvider" property to ""
    And puppet has set its "virtualDirectoryDefaults/@path" property to "/"
    And puppet has set its "virtualDirectoryDefaults/@physicalPath" property to "C:\puppet_test"
    And puppet has set its "virtualDirectoryDefaults/@userName" property to ""
    And puppet has set its "virtualDirectoryDefaults/@password" property to ""
    And puppet has set its "virtualDirectoryDefaults/@logonMethod" property to "ClearText"
    And puppet has set its "virtualDirectoryDefaults/@allowSubDirConfig" property to "true"
    
  Examples:
    | iis_app        |
    | Puppet Test/    |
    | Puppet Test/app |

  Scenario Outline: Create with spaces in physical path
    Given no app called "<iis_app>"
    Given the manifest
    """
      iis_app {'<iis_app>':
        ensure                                      => present,
        applicationpool                             => 'Puppet Test',
        enabledprotocols                            => 'http',
        serviceautostartenabled                     => false,
        serviceautostartprovider                    => '',
        virtualdirectorydefaults_path               => '/',
        virtualdirectorydefaults_physicalpath       => 'C:\puppet test with spaces',
        virtualdirectorydefaults_username           => '',
        virtualdirectorydefaults_password           => '',
        virtualdirectorydefaults_logonmethod        => 'ClearText',
        virtualdirectorydefaults_allowsubdirconfig  => true,
      }
      """
    When puppet applies the manifest
    Then puppet has made changes
    And puppet has created the "<iis_app>" app
    And puppet has set its "@applicationPool" property to "Puppet Test"
    And puppet has set its "@enabledProtocols" property to "http"
    And puppet has set its "@serviceAutoStartEnabled" property to "false"
    And puppet has set its "@serviceAutoStartProvider" property to ""
    And puppet has set its "virtualDirectoryDefaults/@path" property to "/"
    And puppet has set its "virtualDirectoryDefaults/@physicalPath" property to "C:\puppet test with spaces"
    And puppet has set its "virtualDirectoryDefaults/@userName" property to ""
    And puppet has set its "virtualDirectoryDefaults/@password" property to ""
    And puppet has set its "virtualDirectoryDefaults/@logonMethod" property to "ClearText"
    And puppet has set its "virtualDirectoryDefaults/@allowSubDirConfig" property to "true"

  Examples:
    | iis_app        |
    | Puppet Test/    |
    | Puppet Test/app |

  Scenario Outline: Delete
    Given an app called "<iis_app>"
    Given the manifest
    """
      iis_app {'<iis_app>':
        ensure          => absent,
        applicationpool => 'Puppet Test',
      }
      """
    When puppet applies the manifest
    Then puppet has made changes
    And puppet has deleted the "<iis_app>" app
    
  Examples:
    | iis_app        |
    | Puppet Test/    |
    | Puppet Test/app |

  Scenario Outline: Reconfigure
    Given an app called "<iis_app>"
    And its "applicationpool" property is set to "Puppet Test 2"
    And its "enabledprotocols" property is set to "https"
    And its "serviceautostartenabled" property is set to "true"
    And its "serviceautostartprovider" property is set to ""
    And its "virtualdirectorydefaults_path" property is set to "/Puppet Test"
    And its "virtualdirectorydefaults_physicalpath" property is set to "C:\puppet_test2"
    And its "virtualdirectorydefaults_username" property is set to ""
    And its "virtualdirectorydefaults_password" property is set to ""
    And its "virtualdirectorydefaults_logonmethod" property is set to "Batch"
    And its "virtualdirectorydefaults_allowsubdirconfig" property is set to "false"
    Given the manifest
    """
      iis_app {'<iis_app>':
        ensure                                      => present,
        applicationpool                             => 'Puppet Test',
        enabledprotocols                            => 'http',
        serviceautostartenabled                     => false,
        serviceautostartprovider                    => '',
        virtualdirectorydefaults_path               => '/',
        virtualdirectorydefaults_physicalpath       => 'C:\puppet_test',
        virtualdirectorydefaults_username           => '',
        virtualdirectorydefaults_password           => '',
        virtualdirectorydefaults_logonmethod        => 'ClearText',
        virtualdirectorydefaults_allowsubdirconfig  => true,
      }
      """
    When puppet applies the manifest
    Then puppet has made changes
    And puppet has changed the "<iis_app>" app
    And puppet has set its "@applicationPool" property to "Puppet Test"
    And puppet has set its "@enabledProtocols" property to "http"
    And puppet has set its "@serviceAutoStartEnabled" property to "false"
    And puppet has set its "@serviceAutoStartProvider" property to ""
    And puppet has set its "virtualDirectoryDefaults/@path" property to "/"
    And puppet has set its "virtualDirectoryDefaults/@physicalPath" property to "C:\puppet_test"
    And puppet has set its "virtualDirectoryDefaults/@userName" property to ""
    And puppet has set its "virtualDirectoryDefaults/@password" property to ""
    And puppet has set its "virtualDirectoryDefaults/@logonMethod" property to "ClearText"
    And puppet has set its "virtualDirectoryDefaults/@allowSubDirConfig" property to "true"
    
  Examples:
    | iis_app        |
    | Puppet Test/    |
    | Puppet Test/app |
