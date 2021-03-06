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
    self.addToQueueButton.layer.cornerRadius = 12.0;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)didTapAdd:(id)sender {
    //switch button state depending on 1st or 2nd click
    self.addToQueueButton.selected = !self.addToQueueButton.selected;
    //self.addToQueueButton.selected = ![self.track.added boolValue];
    //self.track.added = [NSNumber numberWithInt: self.addToQueueButton.selected ? 1 : 0];
    self.track.addedBy = [[PFUser currentUser] username];
    if(self.room){
        //if adding song to existing room queue
        self.addToQueueButton.selected ? [self.room.sharedQueue addObject:self.track]: [self.room.sharedQueue removeObject:self.track];
        self.room.sharedQueue = [Track JSONSerialize:self.room.sharedQueue];
        [self.room saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
            if (succeeded) {
                NSLog(@"Track added successfully");
                self.room.sharedQueue = [Track JSONDeserialize:self.room.sharedQueue];
            } else {
                NSLog(@"Error adding track");
            }
          }];
    }
    else{
        //if adding song to setup queue prior to room creation
        self.addToQueueButton.selected ? [self.setupQueue addObject:self.track]:[self.setupQueue removeObject:self.track];
    }
}



@end
