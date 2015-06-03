var exec = require('cordova/exec');

exports.updateStorageQuota = function(newQuota, success, error) {
    exec(success, error, "updateQuota", "updateStorageQuota", [newQuota]);
};
