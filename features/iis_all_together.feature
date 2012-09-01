Feature: IIS All Together
  In order to automate the configuration of IIS
  As an ops practitioner
  I want to use Puppet to manage IIS

  Scenario: Creating
    Given no apppool called "PuppetIisDemo"
    Given no site called "PuppetIisDemo"
    Given no app called "PuppetIisDemo/"
    Given no vdir called "PuppetIisDemo/"
    Given the manifest
    """
      file {'c:\puppet_iis_demo':
        ensure          => directory,
      }

      file {'c:\puppet_iis_demo\default.aspx':
        content         =>
'<%@ Page Language="C#" %>
<!DOCTYPE html>
<html>
<head>
    <title>Managed by Puppet</title>
</head>
<body>
    <h1>Managed by Puppet</h1>

    <strong>Time:</strong> <%= DateTime.UtcNow.ToString("s") + "Z" %>
</body>
</html>'
      }

      iis_apppool {'PuppetIisDemo':
        ensure                => present,
        managedpipelinemode   => 'Integrated',
        managedruntimeversion => 'v2.0',
      }

      iis_site {'PuppetIisDemo':
        ensure          => present,
        bindings        => ["http/*:25999:"],
      }

      iis_app {'PuppetIisDemo/':
        ensure          => present,
        applicationpool => 'PuppetIisDemo',
      }

      iis_vdir {'PuppetIisDemo/':
        ensure          => present,
        iis_app         => 'PuppetIisDemo/',
        physicalpath    => 'c:\puppet_iis_demo'
      }
      """
    When puppet applies the manifest
    Then puppet has made changes
    And puppet has created the "PuppetIisDemo" apppool
    And puppet has created the "PuppetIisDemo" site
    And puppet has created the "PuppetIisDemo/" app
    And puppet has created the "PuppetIisDemo/" vdir

  Scenario: Deleting
    Given an apppool called "PuppetIisDemo"
    Given a site called "PuppetIisDemo"
    Given an app called "PuppetIisDemo/"
    Given a vdir called "PuppetIisDemo/" for "PuppetIisDemo/" app
    Given the manifest
    """
      iis_apppool {'PuppetIisDemo':
        ensure          => absent,
      }

      iis_site {'PuppetIisDemo':
        ensure          => absent,
      }

      iis_app {'PuppetIisDemo/':
        ensure          => absent,
        applicationpool => 'PuppetIisDemo',
      }

      iis_vdir {'PuppetIisDemo/':
        ensure          => absent,
        iis_app         => 'PuppetIisDemo/',
      }
      """
    When puppet applies the manifest
    Then puppet has made changes
    And puppet has deleted the "PuppetIisDemo" apppool
    And puppet has deleted the "PuppetIisDemo" site
    And puppet has deleted the "PuppetIisDemo/" app
    And puppet has deleted the "PuppetIisDemo/" vdir
