//
//  Room.h
//  PartyPlay
//
//  Created by Santino L Ramos on 7/20/21.
//

#import <Foundation/Foundation.h>
#import "Parse/Parse.h"

NS_ASSUME_NONNULL_BEGIN

@interface Room : PFObject<PFSubclassing>

@property(nonatomic, strong) NSString *roomName;
@property(nonatomic, strong) NSNumber *joinCode;
@property(nonatomic, strong) NSMutableArray *sharedQueue;
@property(nonatomic, strong) NSNumber *numGuests;

    
@end

NS_ASSUME_NONNULL_END
