//
//  SpotifyAPIManager.h
//  PartyPlay
//
//  Created by Santino L Ramos on 8/4/21.
//

#import <Foundation/Foundation.h>
#import <SpotifyIOS/SpotifyiOS.h>
#import "Track.h"

NS_ASSUME_NONNULL_BEGIN

@interface SpotifyAPIManager : NSObject

+ (instancetype)shared;

- (void)authWithAPI;

- (void)searchWithAPI:(NSString *)query withCompletion:(void(^)(NSMutableArray *results, NSError *error))completion;

- (void)playQueue:(NSString *)frontSong;

- (void)startPlayback;

- (void)pausePlayback;

- (void)skipNext:(void(^)(bool success))completion;

- (void)skipPrevious;

- (void)playTrack:(Track *)track;

- (void)enqueueTrack:(Track *)track :(void(^)(bool success))completion;

- (void)getNowPlayingTrack:(void(^)(NSString *trackName))completion;

- (void)getNowPlayingArtist:(void(^)(NSString *ArtistName))completion;

- (void)getAlbumArt:(void(^)(UIImage *AlbumArt))completion;

- (NSString *)getToken;

- (SPTSessionManager *)getSessionManager;
    
@end

NS_ASSUME_NONNULL_END
