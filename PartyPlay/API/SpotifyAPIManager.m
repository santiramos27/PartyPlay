//
//  SpotifyAPIManager.m
//  PartyPlay
//
//  Created by Santino L Ramos on 8/4/21.
//

#import "SpotifyAPIManager.h"
#import "UIImageView+AFNetworking.h"
#import "AFHTTPSessionManager.h"
#import "APIManager.h"
#import "Track.h"

static NSString * const SpotifyClientID = @"a37725494d5446f389585c9ac6f9f848";
static NSString * const SpotifyRedirectURLString = @"spotify-ios-quick-start://spotify-login-callback";


@interface SpotifyAPIManager()<APIManager, SPTSessionManagerDelegate, SPTAppRemoteDelegate, SPTAppRemotePlayerStateDelegate>

@property (nonatomic, strong) SPTSessionManager *sessionManager;
@property (nonatomic, strong) SPTConfiguration *configuration;
@property (nonatomic, strong) SPTAppRemote *appRemote;
@property (nonatomic, strong) NSString *authToken;

@end

@implementation SpotifyAPIManager

+ (instancetype)shared {
    static SpotifyAPIManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[self alloc] init];
    });
    return sharedManager;
}

- (instancetype)init {
    self.configuration  = [[SPTConfiguration alloc] initWithClientID:SpotifyClientID redirectURL:[NSURL URLWithString:SpotifyRedirectURLString]];
    
    self.configuration.tokenSwapURL = [NSURL URLWithString:@"https://partyplay1.herokuapp.com/api/token"];
    self.configuration.tokenRefreshURL = [NSURL URLWithString:@"https://partyplay1.herokuapp.com/api/refresh_token"];
    self.configuration.playURI = @"spotify:track:20I6sIOMTCkB6w7ryavxtO";
    
    self.sessionManager = [[SPTSessionManager alloc] initWithConfiguration:self.configuration delegate:self];
    
    self.appRemote = [[SPTAppRemote alloc] initWithConfiguration:self.configuration logLevel:SPTAppRemoteLogLevelDebug];
    self.appRemote.delegate = self;
    
    return self;
}

- (void)authWithAPI:(void(^)(BOOL success, NSError * error))completion{
    SPTScope requestedScope = SPTAppRemoteControlScope;
    [self.sessionManager initiateSessionWithScope:requestedScope options:SPTDefaultAuthorizationOption];
    completion(true,nil);
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options{
    [self.sessionManager application:app openURL:url options:options];
    return true;
}

- (void)sessionManager:(SPTSessionManager *)manager didInitiateSession:(SPTSession *)session{
    self.authToken = session.accessToken;
    self.appRemote.connectionParameters.accessToken = session.accessToken;
    [self.appRemote connect];
    NSLog(@"success: %@", session.accessToken);
}

- (void)sessionManager:(SPTSessionManager *)manager didFailWithError:(NSError *)error{
    NSLog(@"fail: %@", error);
}

- (void)sessionManager:(SPTSessionManager *)manager didRenewSession:(SPTSession *)session{
    NSLog(@"renewed: %@", session);
}

- (NSString *)getToken{
    return self.authToken;
}

- (void)searchWithAPI:(NSString *)query withCompletion:(void(^)(NSMutableArray *results, NSError *error))completion{
    NSString *encodedQuery = [query stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSString *URLString = [NSString stringWithFormat:@"https://api.spotify.com/v1/search?q=%@&type=track", encodedQuery];
    
    NSString *token = [NSString stringWithFormat:@"Bearer %@",[[SpotifyAPIManager shared] getToken]];
    
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:URLString]];
    [request setValue:token forHTTPHeaderField:@"Authorization"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];

    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
           if (error != nil) {
               NSLog(@"%@", [error localizedDescription]);
               completion(nil, error);
           }
           else {
               NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
               NSDictionary *tracks = dataDictionary[@"tracks"];
               NSMutableArray *items = [Track tracksWithArray:tracks[@"items"]];
               completion(items, nil);
           }
       }];
    [task resume];
}


- (void)appRemoteDidEstablishConnection:(SPTAppRemote *)appRemote{
    // Connection was successful, you can begin issuing commands
    self.appRemote.playerAPI.delegate = self;
    [self.appRemote.playerAPI subscribeToPlayerState:^(id _Nullable result, NSError * _Nullable error) {
        if (error) {
            NSLog(@"error: %@", error.localizedDescription);
        }
    }];
}

- (void)appRemote:(SPTAppRemote *)appRemote didDisconnectWithError:(NSError *)error{
    NSLog(@"disconnected");
}

- (void)appRemote:(SPTAppRemote *)appRemote didFailConnectionAttemptWithError:(NSError *)error{
    NSLog(@"failed");
}

- (void)playerStateDidChange:(id<SPTAppRemotePlayerState>)playerState{
    NSLog(@"Track name: %@", playerState.track.name);
}

- (void)applicationWillResignActive:(UIApplication *)application{
    if (self.appRemote.isConnected) {
        [self.appRemote disconnect];
    }
}

- (void)applicationDidBecomeActive:(UIApplication *)application{
    if (self.appRemote.connectionParameters.accessToken) {
        [self.appRemote connect];
    }
}

@end