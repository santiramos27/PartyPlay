//
//  LoginViewController.m
//  PartyPlay
//
//  Created by Santino L Ramos on 7/14/21.
//

#import "LoginViewController.h"
#import "Parse/Parse.h"
#import "APIManager.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
    //newUser.email = self.emailField.text;
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
            NSLog(@"User log in failed: %@", error.localizedDescription);
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
