//
//  QueueCell.m
//  PartyPlay
//
//  Created by Santino L Ramos on 7/27/21.
//

#import "QueueCell.h"
#import "Parse/Parse.h"

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
    [self.room saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if (succeeded) {
            NSLog(@"Upvote sucess");
            [self refreshData];
        } else {
            NSLog(@"upvote failed");
        }
      }];
    
}

- (IBAction)didTapDownvote:(id)sender {
    self.track.numUpvotes = [NSNumber numberWithInt:[self.track.numUpvotes intValue] - 1];
    [self.room saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if (succeeded) {
            NSLog(@"Downvote sucess");
            [self refreshData];
        } else {
            NSLog(@"Downvote failed");
        }
      }];
}

- (void)refreshData{
    self.upvoteCountLabel.text = [NSString stringWithFormat:@"%d",[self.track.numUpvotes intValue]];
    self.downvoteCountLabel.text = [NSString stringWithFormat:@"%d",[self.track.numDownvotes intValue]];
}

@end
