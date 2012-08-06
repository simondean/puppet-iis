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
```
3. From your Start Menu run: All Programs\Puppet\Start Command Prompt with Puppet
4. A Puppet command prompt will open.  Change directory to the directory with your iis_example.pp file in and then run this command:
      puppet apply --debug iis_example.pp


## Tested on:

- Ruby 1.9.2 p290 on Windows 7 64bit.

Puppet is not compatible with Ruby 1.9.3 at the moment.  It produces the error: "maxgroups=() function is unimplemented on this machine"


## Copyright

Copyright (c) 2012 Simon Dean. See LICENSE for details.