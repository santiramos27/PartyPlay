//
//  Track.h
//  PartyPlay
//
//  Created by Santino L Ramos on 7/20/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Track : NSObject

@property (strong, nonatomic) NSString *songURI;
@property (strong, nonatomic) NSString *songName;
@property (strong, nonatomic) NSString *artistName;
@property (strong, nonatomic) NSNumber *numVotes;
@property (strong, nonatomic) NSString *addedBy;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
+ (NSMutableArray *)tracksWithArray:(NSArray *)dictionaries;
+ (NSMutableArray *)JSONSerialize:(NSMutableArray *)queue;
+ (NSMutableArray *)JSONDeserialize:(NSMutableArray *)queue;

@end

NS_ASSUME_NONNULL_END
