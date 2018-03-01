#import "RBStringInjector.h"

static NSDictionary* injectables = nil;

@implementation RBStringInjector

- (void)pluginInitialize
{
    [super pluginInitialize];

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        injectables = @{};
    });
}

- (void)get:(CDVInvokedUrlCommand*)command
{
    CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];

    NSString *getKey = [command.arguments objectAtIndex:0];

    if(!getKey || ![self.commandDelegate.settings objectForKey:[getKey lowercaseString]])
    {
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        return;
    }

    NSString* injectable = [self.commandDelegate.settings objectForKey:[getKey lowercaseString]];
    if(!injectable)
    {
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        return;
    }

    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:injectable];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    return;
}

@end
