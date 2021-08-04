//
//  FollowerRoomViewController.m
//  PartyPlay
//
//  Created by Santino L Ramos on 7/26/21.
//

#import "FollowerRoomViewController.h"
#import "Parse/Parse.h"
#import "Track.h"
#import "QueueCell.h"
#import "QueueSetupViewController.h"
#import "SpotifyAPIManager.h"

@import ParseLiveQuery;

@interface FollowerRoomViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UILabel *welcomeLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) UIRefreshControl *refreshControl;


@property (nonatomic, strong) PFLiveQueryClient *liveQueryClient;
@property (nonatomic, strong) PFQuery *query;
@property (nonatomic, strong) PFLiveQuerySubscription *subscription;

@end

@implementation FollowerRoomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.room.sharedQueue = [Track JSONDeserialize:self.room.sharedQueue];
    
    [self refreshControlSetup];
    
    self.welcomeLabel.text = [NSString stringWithFormat:@"Welcome to %@", self.room.roomName];
    
    [self liveQuerySetup];
    
}

- (void)refreshControlSetup{
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(fetchQueue) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:self.refreshControl atIndex:0];
}

- (void)liveQuerySetup{
    self.liveQueryClient = [[PFLiveQueryClient alloc] initWithServer:@"wss://partyplay.b4a.io" applicationId:@"OlNro9zsZF3pl4qjqy1iLond1Glvp0BZrnqkw0SO" clientKey:@"WaZjcXNKrrMU4cZYOaiR1HdvxC9CV5z4m10IhWte"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"roomName == %@ AND roomCode == %@", self.room.roomName, self.room.roomCode];
    self.query = [PFQuery queryWithClassName:@"Room" predicate:predicate];
    self.subscription = [self.liveQueryClient subscribeToQuery:self.query];
    [self.subscription addUpdateHandler:^(PFQuery<PFObject *> * _Nonnull query, PFObject * _Nonnull object) {
        NSLog(@"there has been a change to the room");
        [self fetchQueue];
    }];
    
}
- (IBAction)didTapBeginPlayback:(id)sender {
    Track *curr = self.room.sharedQueue[0];
    //[[SpotifyAPIManager shared] playSong:curr.songURI];
//    for(Track *track in self.room.sharedQueue){
//        [[APIManager shared] playSong:track.songURI];
//    }
}


- (void)fetchQueue{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"roomName == %@ AND roomCode == %@", self.room.roomName, self.room.roomCode];
    PFQuery *query = [PFQuery queryWithClassName:@"Room" predicate:predicate];

    // fetch data asynchronously
    [query findObjectsInBackgroundWithBlock:^(NSArray *rooms, NSError *error) {
        if ([rooms count] != 0) {
            self.room = rooms[0];
            self.room.sharedQueue = [Track JSONDeserialize:self.room.sharedQueue];
            [self.tableView reloadData];
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
        [self.refreshControl endRefreshing];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.room.sharedQueue count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    QueueCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"QueueCell" forIndexPath:indexPath];
    Track *track = self.room.sharedQueue[indexPath.row];
    
    cell.songIndex = [NSNumber numberWithInt:indexPath.row];
    cell.track = track;
    cell.room = self.room;
    
    cell.trackNameLabel.text = track.songName;
    cell.artistNameLabel.text = track.artistName;
    cell.addedByLabel.text = [NSString stringWithFormat: @"Added by: %@", track.addedBy];
    cell.voteLabel.text = [NSString stringWithFormat:@"%@", track.numVotes];
    
    return cell;
}


#pragma mark - Navigation


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    QueueSetupViewController *searchRoom = [segue destinationViewController];
    searchRoom.room = self.room;
    //pass personal profile to ComposeViewController to display profile picture
}


@end
