//
//  HostRoomViewController.m
//  PartyPlay
//
//  Created by Santino L Ramos on 7/26/21.
//

#import "HostRoomViewController.h"
#import "Track.h"
#import "QueueCell.h"
#import "Track.h"

@interface HostRoomViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *welcomeLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *sharedQueue;
@end

@implementation HostRoomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.welcomeLabel.text = [NSString stringWithFormat:@"Welcome to %@", self.room.roomName];
    self.sharedQueue = [Track JSONDeserialize:self.room.sharedQueue];
    // Do any additional setup after loading the view.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.room.sharedQueue count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    QueueCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"QueueCell" forIndexPath:indexPath];
    Track *track = self.sharedQueue[indexPath.row];
    
    cell.songIndex = [NSNumber numberWithInt:indexPath.row];
    cell.track = track;
    cell.room = self.room;
    
    cell.trackNameLabel.text = track.songName;
    cell.artistNameLabel.text = track.artistName;
    cell.addedByLabel.text = track.addedBy;
    cell.voteLabel.text = [NSString stringWithFormat:@"%@", track.numVotes];
    
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
