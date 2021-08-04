//
//  SearchResultCell.m
//  PartyPlay
//
//  Created by Santino L Ramos on 7/23/21.
//

#import "SearchResultCell.h"
#import "Parse/Parse.h"

@implementation SearchResultCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)didTapAdd:(id)sender {
    self.addToQueueButton.selected = true;
    self.track.addedBy = [[PFUser currentUser] username];
    if(self.room){
        //if adding song to existing room queue
        [self.room.sharedQueue addObject:self.track];
        self.room.sharedQueue = [Track JSONSerialize:self.room.sharedQueue];
        [self.room saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
            if (succeeded) {
                NSLog(@"Track added successfully");
            } else {
                NSLog(@"Error adding track");
            }
          }];
    }
    else{
        //if adding song to setup queue prior to room creation
        [self.setupQueue addObject:self.track];
    }
}



@end
