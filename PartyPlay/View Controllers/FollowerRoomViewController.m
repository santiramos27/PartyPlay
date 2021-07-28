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

@import ParseLiveQuery;

@interface FollowerRoomViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UILabel *welcomeLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
//@property (strong, nonatomic) NSMutableArray *sharedQueue;
@property (nonatomic, strong) UIRefreshControl *refreshControl;


@property (nonatomic, strong) PFLiveQueryClient *client;
@property (nonatomic, strong) PFQuery *query;
@property (nonatomic, strong) PFLiveQuerySubscription *subscription;

@end

@implementation FollowerRoomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.welcomeLabel.text = [NSString stringWithFormat:@"Welcome to %@", self.room.roomName];
    //queue currently unpacked, this was done before creating room object
    self.room.sharedQueue = [Track repackTracks:self.room.sharedQueue];
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(reloadQueue) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:self.refreshControl atIndex:0];

    // Do any additional setup after loading the view.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.room.sharedQueue count];
}

- (void)reloadQueue{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"roomName == %@ AND roomCode == %@", self.room.roomName, self.room.roomCode];
    PFQuery *query = [PFQuery queryWithClassName:@"Room" predicate:predicate];

    // fetch data asynchronously
    [query findObjectsInBackgroundWithBlock:^(NSArray *rooms, NSError *error) {
        if ([rooms count] != 0) {
            self.room = rooms[0];
            self.room.sharedQueue = [Track repackTracks:self.room.sharedQueue];
            [self.tableView reloadData];
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
        [self.refreshControl endRefreshing];
    }];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    QueueCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"QueueCell" forIndexPath:indexPath];
    Track *track = self.room.sharedQueue[indexPath.row];
    
    cell.songIndex = [NSNumber numberWithInt:indexPath.row];
    cell.track = track;
    cell.room = self.room;
    
    cell.trackNameLabel.text = track.songName;
    cell.artistNameLabel.text = track.artistName;
    cell.addedByLabel.text = track.addedBy;
    cell.upvoteCountLabel.text = [NSString stringWithFormat:@"%@", track.numUpvotes];
    cell.downvoteCountLabel.text = [NSString stringWithFormat:@"%@", track.numDownvotes];
    
    return cell;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
