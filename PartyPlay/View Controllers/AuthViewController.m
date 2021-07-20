//
//  AuthViewController.m
//  PartyPlay
//
//  Created by Santino L Ramos on 7/20/21.
//

#import "AuthViewController.h"
#import "APIManager.h"

@interface AuthViewController ()

@end

@implementation AuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)didTapConnect:(id)sender {
    [[APIManager shared] spotifyAuth];
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
