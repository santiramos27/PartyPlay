//
//  SharedRoomViewController.m
//  PartyPlay
//
//  Created by Santino L Ramos on 7/21/21.
//

#import "SharedRoomViewController.h"

@interface SharedRoomViewController ()
@property (weak, nonatomic) IBOutlet UILabel *welcomeLabel;


@end

@implementation SharedRoomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.welcomeLabel.text = [NSString stringWithFormat:@"Welcome to %@", self.room.roomName];
    // Do any additional setup after loading the view.
}


@end
