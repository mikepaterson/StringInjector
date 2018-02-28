var exec = require('cordova/exec');

exports.get = function(stringIdentifier, success, error)
{
    exec(success, error, "StringInjector", "get", [stringIdentifier]);
};
