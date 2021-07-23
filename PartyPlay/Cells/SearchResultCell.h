//
//  SearchResultCell.h
//  PartyPlay
//
//  Created by Santino L Ramos on 7/23/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SearchResultCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *trackNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *artistNameLabel;

@end

NS_ASSUME_NONNULL_END
