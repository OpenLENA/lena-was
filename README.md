

# <img src="docs/images/readme_lena_was_head.png" width="800"> [![Build Web Application Server](https://github.com/OpenLENA/lena-was/actions/workflows/build.yml/badge.svg)](https://github.com/OpenLENA/lena-was/actions/workflows/build.yml) [![Quality Gate Status](https://sonarcloud.io/api/project_badges/measure?project=OpenLENA_lena-was&metric=alert_status)](https://sonarcloud.io/dashboard?id=OpenLENA_lena-was) [![Coverage](https://sonarcloud.io/api/project_badges/measure?project=OpenLENA_lena-was&metric=coverage)](https://sonarcloud.io/dashboard?id=OpenLENA_lena-was)


This is the home of the LENA Web Application Server.
LENA provides everything required for creating and configuring Web Application Server so easily.

All feature following will be working with CLI.

The feature of LENA Open Edition : 

+ Core Engine : encrypt datasource password and servlet filter to disable secure attribute of session cookie when set-cookie.

+ Installation : Create, Delete and Clone server. Don't need to type in much things when create server, just required server name and service port.
  Clone server is so useful when you wanna save the status of the server right away.
 
+ Execution : Start, Stop server. You can check the server status just with a command "ps". Just in case, service request is under abnomal status and you need to
              restart the server forcely. Use the command "force restart server_id". 

+ Monitoring : It is possible to capture heap and thread dump using LENA which means that, you don't need to memorize complicated commands like jmap.
               just do that with simple command of LENA.



## Installation and Getting Started
You can get [installation guide](https://github.com/OpenLENA/lena-was/wiki/Installation-Guide) and getting started.

## Getting Help
If you are having some trouble with LENA? Contact us the way you want.
+ Check the [reference documentation](https://github.com/OpenLENA/lena-was/wiki).
+ Notify us the problem by using [GitHub's Issue](https://github.com/OpenLENA/lena-was/issues/new).
+ Feel free to join our [community](https://groups.google.com/g/lena-oe) and ask that to us.

## Reporting Issues
We use GitHub's integrated issue tracking system to record bugs and other issues. Following are recommendations to keep the rule for reporing issues.
+ Check what the issue you found out is already ([recorded](https://github.com/OpenLENA/lena-was/issues) or not.
+ If there is nothing, [Create issues](https://github.com/OpenLENA/lena-was/issues/new).
+ Keep the rule for commit message.
+ If possible, try to create a test-case.

## Modules
There are several modules in LENA Open Edition:

[**was-core**](https://github.com/OpenLENA/lena-was/tree/master/was-core)

It is engine core module of LENA.

[**was-oss**](https://github.com/OpenLENA/lena-was/tree/master/was-oss)

It has packages including OSS for using LENA.

[**was-dist**](https://github.com/OpenLENA/lena-was/tree/master/was-dist)

Packaging module for installation files of LENA

## Release
LENA will be released every each quarter. You can get [released files]() and check what is changed in [release note](https://github.com/OpenLENA/lena-was/wiki).

## Roadmap
You can find a roadmap of LENA [here](https://github.com/OpenLENA/lena-was/wiki/2021-Roadmap).

## Community
[LENA Community](https://groups.google.com/g/openlena)

## License
LENA Web Application Server Opensource Edition is Open Source software released under the Apache 2.0 license.
