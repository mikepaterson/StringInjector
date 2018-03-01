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

    if(!getKey || ![self.commandDelegate.settings objectForKey:getKey])
    {
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        return;
    }

    NSString* injectable = [self.commandDelegate.settings objectForKey:getKey];

    /*
    if(!getKey || ![injectables objectForKey:getKey])
    {
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        return;
    }

    NSString *injectable = [injectables objectForKey:getKey];
    */
    
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
