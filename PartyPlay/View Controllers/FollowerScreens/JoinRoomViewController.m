//
//  JoinRoomViewController.m
//  PartyPlay
//
//  Created by Santino L Ramos on 7/21/21.
//

#import "JoinRoomViewController.h"
#import "Parse/Parse.h"
#import "Room.h"
#import "FollowerRoomViewController.h"
#import "SceneDelegate.h"
#import "HomeViewController.h"

@interface JoinRoomViewController ()

@property (weak, nonatomic) IBOutlet UITextField *roomNameField;
@property (weak, nonatomic) IBOutlet UITextField *roomCodeField;
@property (strong, nonatomic) Room *room;
@property (weak, nonatomic) IBOutlet UIButton *joinRoomButton;

@end

@implementation JoinRoomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.joinRoomButton.layer.cornerRadius = 12.0;
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
    SceneDelegate *myDelegate = (SceneDelegate *)self.view.window.windowScene.delegate;
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    HomeViewController *homeViewController = [storyboard instantiateViewControllerWithIdentifier:@"HomeViewController"];
    myDelegate.window.rootViewController = homeViewController;
}

- (IBAction)onTap:(id)sender {
    [self.view endEditing:true];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier  isEqual: @"joinSegue"] ){
        FollowerRoomViewController *followerRoom = [segue destinationViewController];
        followerRoom.room = self.room;
        //pass personal profile to ComposeViewController to display profile picture
    }
}


@end
