//
//  AuthViewController.m
//  PartyPlay
//
//  Created by Santino L Ramos on 7/20/21.
//

#import "AuthViewController.h"
#import "SpotifyAPIManager.h"
#import "SceneDelegate.h"
#import "LoginViewController.h"
#import "Parse/Parse.h"

@interface AuthViewController ()

@end

@implementation AuthViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //[[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"spotify:"]];
    // Do any additional setup after loading the view.
}

- (IBAction)didTapConnect:(id)sender {
    [[SpotifyAPIManager shared] authWithAPI];
    [self performSegueWithIdentifier:@"authSegue" sender:nil];
}


- (IBAction)didTapLogout:(id)sender {
    SceneDelegate *myDelegate = (SceneDelegate *)self.view.window.windowScene.delegate;
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    myDelegate.window.rootViewController = loginViewController;
    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
        if(error){
            NSLog(@"Logout Failed");
        }
    }];
}


@end
