//
//  SearchResultCell.h
//  PartyPlay
//
//  Created by Santino L Ramos on 7/23/21.
//

#import <UIKit/UIKit.h>
#import "Track.h"

NS_ASSUME_NONNULL_BEGIN

@interface SearchResultCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *trackNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *artistNameLabel;
@property (strong, nonatomic) Track *track;
@property (strong, nonatomic) NSMutableArray *sharedQueue;
@property (weak, nonatomic) IBOutlet UIButton *addToQueueButton;

@end

NS_ASSUME_NONNULL_END
