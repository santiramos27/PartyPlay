//
//  SharedRoomViewController.h
//  PartyPlay
//
//  Created by Santino L Ramos on 7/21/21.
//

#import <UIKit/UIKit.h>
#import "Room.h"

NS_ASSUME_NONNULL_BEGIN

@interface SharedRoomViewController : UIViewController

@property (strong, nonatomic) NSMutableArray *sharedQueue;
@property (strong, nonatomic) Room *room;

@end

NS_ASSUME_NONNULL_END
