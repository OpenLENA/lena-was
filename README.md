

# <img src="docs/images/readme_lena_was_head.png" width="800"> [![Build Web Application Server](https://github.com/ArchiSol/lena-was-oe/actions/workflows/build.yml/badge.svg)](https://github.com/ArchiSol/lena-was-oe/actions/workflows/build.yml)  [![Quality Gate Status](https://sonarcloud.io/api/project_badges/measure?project=ArchiSol_lena-was-oe&metric=alert_status&token=13de34a156939495270d3bef512b03eda0c179fe)](https://sonarcloud.io/dashboard?id=ArchiSol_lena-was-oe)  [![Coverage](https://sonarcloud.io/api/project_badges/measure?project=ArchiSol_lena-was-oe&metric=coverage&token=13de34a156939495270d3bef512b03eda0c179fe)](https://sonarcloud.io/dashboard?id=ArchiSol_lena-was-oe)


This is the home of the LENA Web Application Server.
LENA provides everything required for creating and configuring Web Application Server so easily.

All feature following will be working with CLI.

The feature of LENA Open Edition : 

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


## Community
[LENA Community](https://groups.google.com/g/lena-oe)

## License
LENA Web Application Server Opensource Edition is Open Source software released under the Apache 2.0 license.
