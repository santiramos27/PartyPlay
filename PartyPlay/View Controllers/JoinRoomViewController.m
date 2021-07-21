//
//  JoinRoomViewController.m
//  PartyPlay
//
//  Created by Santino L Ramos on 7/21/21.
//

#import "JoinRoomViewController.h"
#import "Parse/Parse.h"
#import "Room.h"
#import "SharedRoomViewController.h"

@interface JoinRoomViewController ()

@property (weak, nonatomic) IBOutlet UITextField *roomNameField;
@property (weak, nonatomic) IBOutlet UITextField *roomCodeField;
@property (strong, nonatomic) Room *room;

@end

@implementation JoinRoomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)didTapJoin:(id)sender {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"roomName == %@ AND roomCode == %@", self.roomNameField.text, self.roomCodeField.text];
    PFQuery *query = [PFQuery queryWithClassName:@"Room" predicate:predicate];

    // fetch data asynchronously
    [query findObjectsInBackgroundWithBlock:^(NSArray *rooms, NSError *error) {
        if ([rooms count] != 0) {
            self.room = rooms[0];
            [self performSegueWithIdentifier:@"joinSegue" sender:nil];
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
    
}
- (IBAction)didTapCancel:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier  isEqual: @"joinSegue"] ){
        SharedRoomViewController *sharedRoom = [segue destinationViewController];
        sharedRoom.room = self.room;
        //pass personal profile to ComposeViewController to display profile picture
    }
}


@end
