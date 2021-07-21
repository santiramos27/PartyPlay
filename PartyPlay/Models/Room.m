//
//  Room.m
//  PartyPlay
//
//  Created by Santino L Ramos on 7/20/21.
//

#import "Room.h"

@implementation Room

@dynamic roomName;
@dynamic joinCode;
@dynamic sharedQueue;
@dynamic numGuests;
@dynamic host;

+ (nonnull NSString *)parseClassName {
        return @"Room";
    }

+ (void) createRoom: (NSString * _Nullable)name withCode: ( NSString * _Nullable )code withCompletion: (PFBooleanResultBlock  _Nullable)completion{
    Room  *room = [Room new];
    room.roomName = name;
    room.joinCode = code;
    room.host = [PFUser currentUser];
    
    [room saveInBackgroundWithBlock:completion];
}

@end
