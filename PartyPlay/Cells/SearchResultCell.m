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
    [self.sharedQueue addObject:self.track];
    NSLog(@"track added");
}



@end
