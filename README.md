puppet-iis
==========

Puppet module for configuring IIS.  Currently it can configure app pools, sites, applications and virtual directories.

## Pre-requisites

- Windows
- Puppet installed via the Windows Installer
- IIS installed

## Example Usage

1. Copy the modules\iis directory into C:\ProgramData\PuppetLabs\puppet\etc\modules, so that you have a C:\ProgramData\PuppetLabs\puppet\etc\modules\iis directory.
2. Create a iis_example.pp file somewhere on your hard disk else with this contents:
```puppet
      file {'c:/puppet_iis_demo':
        ensure          => directory,
      }

      file {'c:/puppet_iis_demo/default.aspx':
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
```
3. From your Start Menu run: All Programs\Puppet\Start Command Prompt with Puppet
4. A Puppet command prompt will open.  Change directory to the directory with your iis_example.pp file in and then run this command:
      puppet apply --debug iis_example.pp


## Tested on:

- Ruby 1.9.2 p290 on Windows 7 64bit.

Puppet is not compatible with Ruby 1.9.3 at the moment.  It produces the error: "maxgroups=() function is unimplemented on this machine"


## Copyright

Copyright (c) 2012 Simon Dean. See LICENSE for details.