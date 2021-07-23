//
//  CreateRoomViewController.m
//  PartyPlay
//
//  Created by Santino L Ramos on 7/21/21.
//

#import "CreateRoomViewController.h"
#import "SceneDelegate.h"
#import "Room.h"
#import "SharedRoomViewController.h"

@interface CreateRoomViewController ()
@property (weak, nonatomic) IBOutlet UITextField *roomNameField;
@property (weak, nonatomic) IBOutlet UITextField *roomCodeField;
@property (strong, nonatomic) Room *room;

@end

@implementation CreateRoomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)didTapCreate:(id)sender {
    self.room.roomName = self.roomNameField.text;
    self.room.roomCode = self.roomCodeField.text;
    
    [Room createRoom:self.roomNameField.text withCode:self.roomCodeField.text withCompletion:^(BOOL succeeded, NSError * _Nullable error){
            if(succeeded){
                [self performSegueWithIdentifier:@"roomSegue" sender:nil];
            }
            else{
                NSLog(@"Room creation failed");
            }
    }];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    SharedRoomViewController *sharedRoom = [segue destinationViewController];
    sharedRoom.room = self.room;
}



@end
