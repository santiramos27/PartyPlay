//
//  Track.h
//  PartyPlay
//
//  Created by Santino L Ramos on 7/20/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Track : NSObject

@property (strong, nonatomic) NSString *songID;
@property (strong, nonatomic) NSString *songName;
@property (strong, nonatomic) NSString *artistName;
@property (strong, nonatomic) NSNumber *numUpvotes;
@property (strong, nonatomic) NSNumber *numDownvotes;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
+ (NSMutableArray *)tracksWithArray:(NSArray *)dictionaries;

@end

NS_ASSUME_NONNULL_END
