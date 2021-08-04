//
//  QueueCell.m
//  PartyPlay
//
//  Created by Santino L Ramos on 7/27/21.
//

#import "QueueCell.h"
#import "Parse/Parse.h"
#import "Track.h"

@implementation QueueCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)didTapUpvote:(id)sender {
    self.track.numUpvotes = [NSNumber numberWithInt:[self.track.numUpvotes intValue] + 1];
    [self.room.sharedQueue replaceObjectAtIndex:[self.songIndex intValue] withObject:self.track];
    self.room.sharedQueue = [Track JSONSerialize:self.room.sharedQueue];
    [self.room saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if (succeeded) {
            NSLog(@"Upvote success");
            [self updateViews];
        } else {
            NSLog(@"upvote failed");
        }
      }];
    
}

- (IBAction)didTapDownvote:(id)sender {
    self.track.numDownvotes = [NSNumber numberWithInt:[self.track.numDownvotes intValue] + 1];
    [self.room.sharedQueue replaceObjectAtIndex:[self.songIndex intValue] withObject:self.track];
    self.room.sharedQueue = [Track JSONSerialize:self.room.sharedQueue];
    [self.room saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if (succeeded) {
            NSLog(@"Downvote success");
            [self updateViews];
        } else {
            NSLog(@"Downvote failed");
        }
      }];
}

- (void)updateViews{
    self.upvoteCountLabel.text = [NSString stringWithFormat:@"%d",[self.track.numUpvotes intValue]];
    self.downvoteCountLabel.text = [NSString stringWithFormat:@"%d",[self.track.numDownvotes intValue]];
}

@end
