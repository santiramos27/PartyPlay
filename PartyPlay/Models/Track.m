//
//  Track.m
//  PartyPlay
//
//  Created by Santino L Ramos on 7/20/21.
//

#import "Track.h"

@implementation Track

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    self.songID = dictionary[@"id"];
    self.songName = dictionary[@"name"];
    
    //this gets the "main" artist from the list of people collaborating on the song.
    NSArray *artists = dictionary[@"artists"];
    NSDictionary *artist = artists[0];
    self.artistName = artist[@"name"];
    self.numDownvotes = [NSNumber numberWithInt:0];
    self.numUpvotes = [NSNumber numberWithInt:0];
    
    return self;
}

+ (NSMutableArray *)tracksWithArray:(NSArray *)dictionaries{
    NSMutableArray *tracks = [NSMutableArray array];
    for (NSDictionary *dictionary in dictionaries) {
        Track *track = [[Track alloc] initWithDictionary:dictionary];
        [tracks addObject:track];
    }
    return tracks;
}

+ (NSMutableArray *)unPackTracks:(NSMutableArray *)queue{
    NSMutableArray *unpacked = [NSMutableArray array];
    for (Track *track in queue){
        NSDictionary *song = [[NSDictionary alloc] initWithObjectsAndKeys:track.songID, @"songID", track.songName, @"songName", track.artistName, @"artistName", track.numUpvotes, @"numUpvotes", track.numDownvotes, @"numDownvotes", track.addedBy, @"addedBy", nil];
        [unpacked addObject:song];
    }
    return unpacked;
}

+ (NSMutableArray *)repackTracks:(NSMutableArray *)queue{
    NSMutableArray *packed = [NSMutableArray array];
    for(NSDictionary *dict in queue){
        Track *track = [[Track alloc] init];
        track.songID = dict[@"songID"];
        track.songName = dict[@"songName"];
        track.artistName = dict[@"artistName"];
        track.numDownvotes = dict[@"numDownvotes"];
        track.numUpvotes = dict[@"numUpvotes"];
        track.addedBy = dict[@"addedBy"];
        [packed addObject:track];
    }
    return packed;
}
@end
