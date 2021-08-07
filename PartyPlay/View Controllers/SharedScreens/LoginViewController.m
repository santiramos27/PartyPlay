//
//  LoginViewController.m
//  PartyPlay
//
//  Created by Santino L Ramos on 7/14/21.
//

#import "LoginViewController.h"
#import "Parse/Parse.h"
#import "SpotifyAPIManager.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UIButton *signInButton;
@property (weak, nonatomic) IBOutlet UIButton *logInButton;
@property (weak, nonatomic) IBOutlet UIImageView *logoView;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.signInButton.layer.cornerRadius = 12.0;
    self.logInButton.layer.cornerRadius = 12.0;
    self.logoView.layer.masksToBounds = true;
    self.logoView.layer.cornerRadius = self.logoView.bounds.size.width / 2;
    // Do any additional setup after loading the view.
}
- (IBAction)onTap:(id)sender {
    [self.view endEditing:true];
}

- (IBAction)didTapLogin:(id)sender {
    [self loginUser];
}

- (IBAction)didTapRegister:(id)sender {
    [self registerUser];
}

- (void)registerUser {
    // initialize a user object
    PFUser *newUser = [PFUser user];
    
    // set user properties
    newUser.username = self.usernameField.text;
    newUser.password = self.passwordField.text;
    
    // call sign up function on the object
    [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * error) {
        if (error != nil) {
            [self displayError:error.localizedDescription];
        } else {
            [self performSegueWithIdentifier:@"loginSegue" sender:nil];
        }
    }];
    
}

- (void)loginUser {
    NSString *username = self.usernameField.text;
    NSString *password = self.passwordField.text;
    
    [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser * user, NSError *  error) {
        if (error != nil) {
            [self displayError:error.localizedDescription];
        } else {
            NSLog(@"User logged in successfully");
            
            // display view controller that needs to shown after successful login
            [self performSegueWithIdentifier:@"loginSegue" sender:nil];
        }
    }];
}

- (void) displayError:(NSString*)err{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"User login failed"message:err preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Ok"style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    // add the 'try again' action to the alertController
    [alert addAction:okAction];
    [self presentViewController:alert animated:YES completion:^{
    }];
    
}


@end
