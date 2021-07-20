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

- (void)spotifyAuth;


@end

NS_ASSUME_NONNULL_END
