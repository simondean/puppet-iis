puppet-iis
==========

Puppet module for configuring IIS.  Currently it can configure app pools, sites, applications and virtual directories.

The module is available from: http://forge.puppetlabs.com/simondean/iis

## Pre-requisites

- Windows
- Puppet installed via the Windows Installer
- IIS installed

The module works with IIS 7 and 7.5.  It does not work with IIS 6 or earlier as those versions of IIS did not include the appcmd tool.

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


## Running the Acceptance Tests

Before you can run the acceptance tests, you need to install the bundler gem and then install the module's "bundle".  You can do this by running: 

```
    >gem install bundler
	>bundle install
```

You can then run the acceptance tests with this command: 

```
	>bundle exec rake acceptance_test
```


## Tested on:

- Tested against the Windows installer version of Puppet on Windows 7 64bit.  

If using the rake build scipt, you need to use Ruby 1.9.2


## Copyright

Copyright (c) 2012 Simon Dean. See LICENSE for details.
