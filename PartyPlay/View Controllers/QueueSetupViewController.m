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
    [self getSearchResults:self.searchBar.text];
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    self.searchBar.showsCancelButton = YES;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    self.searchBar.showsCancelButton = NO;
    self.searchBar.text = @"";
    [self.searchBar resignFirstResponder];
}

- (void)getSearchResults:(NSString *)query {
    NSString *encodedQuery = [query stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSString *URLString = [NSString stringWithFormat:@"https://api.spotify.com/v1/search?q=%@&type=track", encodedQuery];
    
    NSString *token = [NSString stringWithFormat:@"Bearer %@",[[APIManager shared] getToken]];
    
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:URLString]];
    [request setValue:token forHTTPHeaderField:@"Authorization"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];

    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
           if (error != nil) {
               NSLog(@"%@", [error localizedDescription]);
           }
           else {
               NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
               NSDictionary *dict = dataDictionary[@"tracks"];
               self.results = [Track tracksWithArray:dict[@"items"]];
               [self.tableView reloadData];
           }
       }];
    [task resume];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.results count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SearchResultCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"SearchResultCell" forIndexPath:indexPath];
    
    Track *track = self.results[indexPath.row];
    NSLog(@"%@", track.artistName);
    cell.sharedQueue = self.sharedQueue;
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
