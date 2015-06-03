# Cordova Update-Quota plugin

## Install

Install by executing `cordova plugin add <folder>` where <folder> is the directory for this plugin containing the `plugin.xml` file.

## How to use

```
var newQuota = 100000000;
cordova.require("com.thinkwisesoftware.update-quota.updateQuota").updateStorageQuota(newQuota, successCallback, errorCallback);
```
