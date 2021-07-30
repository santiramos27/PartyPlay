//
//  QueueSetupViewController.m
//  PartyPlay
//
//  Created by Santino L Ramos on 7/21/21.
//

#import "QueueSetupViewController.h"
#import "AFNetworking.h"
#import "APIManager.h"
#import "SceneDelegate.h"
#import "HomeViewController.h"
#import "Track.h"
#import "SearchResultCell.h"
#import "CreateRoomViewController.h"

@interface QueueSetupViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic) NSArray *results;
@property (nonatomic, strong) NSMutableArray *sharedQueue;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation QueueSetupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    NSMutableArray *shared = [NSMutableArray array];
    self.sharedQueue = shared;
    // Do any additional setup after loading the view.
}

- (IBAction)didTapCancel:(id)sender {
    SceneDelegate *myDelegate = (SceneDelegate *)self.view.window.windowScene.delegate;
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    HomeViewController *homeViewController = [storyboard instantiateViewControllerWithIdentifier:@"HomeViewController"];
    myDelegate.window.rootViewController = homeViewController;
}

- (IBAction)didTapSearch:(id)sender {
    [self fetchSearchResults:self.searchBar.text];
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    self.searchBar.showsCancelButton = YES;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    self.searchBar.showsCancelButton = NO;
    self.searchBar.text = @"";
    [self.searchBar resignFirstResponder];
}

- (void)fetchSearchResults:(NSString *)query {
    [[APIManager shared] getSearchResults:query withCompletion:^(NSMutableArray *results, NSError *error) {
        if (results) {
            self.results = results;
            [self.tableView reloadData];
            
        } else {
            NSLog(@"Search failed");
        }
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.results count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SearchResultCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"SearchResultCell" forIndexPath:indexPath];
    Track *track = self.results[indexPath.row];
    if(self.room){
        cell.room = self.room;
    }
    else{
        cell.setupQueue = self.sharedQueue;
    }
    cell.track = track;
    cell.trackNameLabel.text = track.songName;
    cell.artistNameLabel.text = track.artistName;
    return cell;
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    CreateRoomViewController *createRoom = [segue destinationViewController];
    createRoom.sharedQueue = self.sharedQueue;
}


@end
