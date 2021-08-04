//
//  QueueCell.h
//  PartyPlay
//
//  Created by Santino L Ramos on 7/27/21.
//

#import <UIKit/UIKit.h>
#import "Track.h"
#import "Room.h"

NS_ASSUME_NONNULL_BEGIN

@interface QueueCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *trackNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *artistNameLabel;
@property (weak, nonatomic) IBOutlet UIButton *upvoteButton;
@property (weak, nonatomic) IBOutlet UIButton *downvoteButton;
@property (weak, nonatomic) IBOutlet UILabel *voteLabel;
@property (weak, nonatomic) IBOutlet UILabel *addedByLabel;

@property (strong, nonatomic) Track *track;
@property (strong, nonatomic) Room *room;

@property (strong, nonatomic) NSNumber *songIndex;

@end

NS_ASSUME_NONNULL_END
