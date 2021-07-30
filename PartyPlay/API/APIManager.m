//
//  APIManager.m
//  PartyPlay
//
//  Created by Santino L Ramos on 7/16/21.
//

#import "APIManager.h"
#import "UIImageView+AFNetworking.h"
#import "AFHTTPSessionManager.h"
#import "Track.h"

static NSString * const SpotifyClientID = @"a37725494d5446f389585c9ac6f9f848";
static NSString * const SpotifyRedirectURLString = @"spotify-ios-quick-start://spotify-login-callback";


@interface APIManager()<SPTSessionManagerDelegate, SPTAppRemoteDelegate, SPTAppRemotePlayerStateDelegate>

@property (nonatomic, strong) SPTSessionManager *sessionManager;
@property (nonatomic, strong) SPTConfiguration *configuration;
@property (nonatomic, strong) SPTAppRemote *appRemote;
@property (nonatomic, strong) NSString *authToken;

@end

@implementation APIManager

+ (instancetype)shared {
    static APIManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[self alloc] init];
    });
    return sharedManager;
}

- (instancetype)init {
    self.configuration  = [[SPTConfiguration alloc] initWithClientID:SpotifyClientID redirectURL:[NSURL URLWithString:SpotifyRedirectURLString]];
    self.sessionManager = [[SPTSessionManager alloc] initWithConfiguration:self.configuration delegate:self];
    
    self.configuration.playURI = @"spotify:track:79s5XnCN4TJKTVMSmOx8Ep";
    self.configuration.tokenSwapURL = [NSURL URLWithString:@"https://partyplay1.herokuapp.com/api/token"];
    self.configuration.tokenRefreshURL = [NSURL URLWithString:@"https://partyplay1.herokuapp.com/api/refresh_token"];
    
    return self;
}

- (void)spotifyAuth:(void(^)(BOOL success, NSError * error))completion{
    SPTScope requestedScope = SPTAppRemoteControlScope;
    [self.sessionManager initiateSessionWithScope:requestedScope options:SPTDefaultAuthorizationOption];
    completion(true,nil);
}

- (void)playSong:(NSString *)songID{
    self.configuration.playURI = songID;
    self.appRemote = [[SPTAppRemote alloc] initWithConfiguration:self.configuration logLevel:SPTAppRemoteLogLevelDebug];
    self.appRemote.delegate = self;
    self.appRemote.connectionParameters.accessToken = [self getToken];
    [self.appRemote connect];
}

- (NSString *)getToken{
    return self.authToken;
}

- (void)getSearchResults:(NSString *)query withCompletion:(void(^)(NSMutableArray *results, NSError *error))completion {
    NSString *encodedQuery = [query stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSString *URLString = [NSString stringWithFormat:@"https://api.spotify.com/v1/search?q=%@&type=track", encodedQuery];
    
    NSString *token = [NSString stringWithFormat:@"Bearer %@",[[APIManager shared] getToken]];
    
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


- (void)sessionManager:(SPTSessionManager *)manager didInitiateSession:(SPTSession *)session{
    self.authToken = session.accessToken;
    NSLog(@"success: %@", session.accessToken);
}

- (void)sessionManager:(SPTSessionManager *)manager didFailWithError:(NSError *)error{
    NSLog(@"fail: %@", error);
}

- (void)sessionManager:(SPTSessionManager *)manager didRenewSession:(SPTSession *)session{
    NSLog(@"renewed: %@", session);
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options{
    [self.sessionManager application:app openURL:url options:options];
    return true;
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
