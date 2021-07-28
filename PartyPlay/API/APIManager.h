//
//  APIManager.h
//  PartyPlay
//
//  Created by Santino L Ramos on 7/16/21.
//

#import <Foundation/Foundation.h>
#import <SpotifyIOS/SpotifyiOS.h>

NS_ASSUME_NONNULL_BEGIN

@interface APIManager : NSObject

+ (instancetype)shared;

- (void)spotifyAuth:(void(^)(BOOL success, NSError * error))completion;

- (void)getSearchResults:(NSString *)query withCompletion:(void(^)(NSMutableArray *results, NSError *error))completion;

- (NSString *)getToken;


@end

NS_ASSUME_NONNULL_END
