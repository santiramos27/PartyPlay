//
//  CreateRoomViewController.m
//  PartyPlay
//
//  Created by Santino L Ramos on 7/21/21.
//

#import "CreateRoomViewController.h"
#import "SceneDelegate.h"
#import "Room.h"
#import "HostRoomViewController.h"
#import "Track.h"

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
    Room *room = [[Room alloc] init];
    room.roomName = self.roomNameField.text;
    room.roomCode = self.roomCodeField.text;
    room.sharedQueue = [Track unPackTracks:self.sharedQueue];
    self.room = room;
    
    [Room createRoom:self.room.roomName withCode:self.room.roomCode withQueue:self.room.sharedQueue withCompletion:^(BOOL succeeded, NSError * _Nullable error){
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
    HostRoomViewController *hostRoom = [segue destinationViewController];
    hostRoom.room = self.room;
}



@end
