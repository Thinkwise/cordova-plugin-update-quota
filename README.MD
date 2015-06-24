# Cordova Update-Quota plugin

On iOS when an application stores around 50MB data on a mobile device the following error occurs:
>SecurityError: DOM Exception 18: An attempt was made to break through the security policy of the user agent.

The `Update-Quota` plugin provides a fix for this issue.

## Install

Clone this repo and install the plugin by executing `cordova plugin add <folder>` where `<folder>` is the directory for this plugin containing the `plugin.xml` file.

## How to use

```JavaScript
var newQuota = 100 * 1024 * 1024; // 100MB
cordova.require("com.thinkwisesoftware.update-quota.updateQuota").updateStorageQuota(newQuota, successCallback, errorCallback);
```

## Supported platform

 * iOS
