//
//  AppDelegate.m
//  PartyPlay
//
//  Created by Santino L Ramos on 7/14/21.
//

#import "AppDelegate.h"
#import "Parse/Parse.h"
@import ParseLiveQuery;

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    ParseClientConfiguration *config = [ParseClientConfiguration  configurationWithBlock:^(id<ParseMutableClientConfiguration> configuration) {

        configuration.applicationId = @"OlNro9zsZF3pl4qjqy1iLond1Glvp0BZrnqkw0SO";
        configuration.clientKey = @"WaZjcXNKrrMU4cZYOaiR1HdvxC9CV5z4m10IhWte";
        configuration.server = @"https://parseapi.back4app.com";
    }];
    PFLiveQueryClient *client = [[PFLiveQueryClient alloc] initWithServer:@"wss://partyplay.b4a.io" applicationId:@"OlNro9zsZF3pl4qjqy1iLond1Glvp0BZrnqkw0SO" clientKey:@"WaZjcXNKrrMU4cZYOaiR1HdvxC9CV5z4m10IhWte"];
    
    

    [Parse initializeWithConfiguration:config];

    return YES;
}


#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}


@end
