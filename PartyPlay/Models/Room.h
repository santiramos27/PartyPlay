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
@property(nonatomic, strong) NSString *roomCode;
@property(nonatomic, strong) NSMutableArray *sharedQueue;
@property(nonatomic, strong) NSNumber *numGuests;
@property(nonatomic, strong) PFUser *host;


+ (nonnull NSString *)parseClassName;

+ (void) createRoom: (NSString * _Nullable)name withCode: ( NSString * _Nullable )code withCompletion: (PFBooleanResultBlock  _Nullable)completion;


@end

NS_ASSUME_NONNULL_END
