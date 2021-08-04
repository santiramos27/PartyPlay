//
//  SpotifyAPIManager.h
//  PartyPlay
//
//  Created by Santino L Ramos on 8/4/21.
//

#import <Foundation/Foundation.h>
#import <SpotifyIOS/SpotifyiOS.h>

NS_ASSUME_NONNULL_BEGIN

@interface SpotifyAPIManager : NSObject

+ (instancetype)shared;

- (void)authWithAPI:(void(^)(BOOL success, NSError * error))completion;

- (void)searchWithAPI:(NSString *)query withCompletion:(void(^)(NSMutableArray *results, NSError *error))completion;

//- (void)playSong:(NSString *)songID;

- (NSString *)getToken;

@end

NS_ASSUME_NONNULL_END
