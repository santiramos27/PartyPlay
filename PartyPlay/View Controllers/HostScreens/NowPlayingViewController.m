//
//  NowPlayingViewController.m
//  PartyPlay
//
//  Created by Santino L Ramos on 8/6/21.
//

#import "NowPlayingViewController.h"
#import "SpotifyAPIManager.h"
#import "Room.h"
#import "Track.h"

@interface NowPlayingViewController ()
@property (weak, nonatomic) IBOutlet UILabel *roomNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *hostNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *albumArtImage;
@property (weak, nonatomic) IBOutlet UILabel *songTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *artistLabel;
@property (weak, nonatomic) IBOutlet UIButton *playPauseButton;


@end

@implementation NowPlayingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.roomNameLabel.text = self.room.roomName;
    self.hostNameLabel.text = [[PFUser currentUser] username];
    [[SpotifyAPIManager shared] getNowPlayingTrack:^(NSString * _Nonnull trackName) {
            self.songTitleLabel.text = trackName;
    }];
    [[SpotifyAPIManager shared] getNowPlayingArtist:^(NSString * _Nonnull artistName) {
            self.artistLabel.text = artistName;
    }];
    
    // Do any additional setup after loading the view.
}
- (IBAction)didTapPlayPause:(id)sender {
    self.playPauseButton.selected = !self.playPauseButton.selected;
    self.playPauseButton.selected ? [[SpotifyAPIManager shared] pausePlayback] : [[SpotifyAPIManager shared] startPlayback];
}
- (IBAction)didTapBackwards:(id)sender {
    [[SpotifyAPIManager shared] skipPrevious];
}
- (IBAction)didTapForwards:(id)sender {
    //enqueue next top song
    Track *nextSong = self.room.sharedQueue[0];
    [[SpotifyAPIManager shared] enqueueTrack:nextSong :^(bool success) {
        if(success){
            [self.room.sharedQueue removeObject:nextSong];
            self.room.sharedQueue = [Track JSONSerialize:self.room.sharedQueue];
            [self.room saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
                if (succeeded) {
                    NSLog(@"Push success");
                    [[SpotifyAPIManager shared] skipNext];
                } else {
                    NSLog(@"Push failed");
                }
              }];
        }
    }];
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
