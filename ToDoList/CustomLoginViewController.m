//
//  CustomLoginViewController.m
//  ToDoList
//
//  Created by Esa Serog on 2/2/16.
//  Copyright © 2016 Julian Serog. All rights reserved.
//

#import "CustomLoginViewController.h"
#define lightGray [UIColor colorWithRed:205/255.0 green:201/255.0 blue:201/255.0 alpha:1]

@interface CustomLoginViewController ()

@end

@implementation CustomLoginViewController



//MARK: view did load
- (void)viewDidLoad
{
    [super viewDidLoad];
    //add elements to view
    [self addElements];
}//ViewDidLoad


-(void)addElements
{
    //init parse user
    self.user = [[PFUser alloc]init];
    
    //label
    self.viewLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height * 0.10)];
    [self.viewLabel setTextAlignment:NSTextAlignmentCenter];
    [self.viewLabel setText:@"Create an Account!"];
    [self.viewLabel setBackgroundColor:[UIColor blackColor]];
    [self.viewLabel setTextColor:[UIColor whiteColor]];
    
    self.email = [[UITextField alloc]initWithFrame:CGRectMake(self.view.frame.size.width * 0.2, self.view.frame.size.height * 0.3, self.view.frame.size.width * 0.6, self.view.frame.size.height * 0.05)];
    [self.email setPlaceholder:@"Email address"];
    self.email.layer.cornerRadius = 5;
    [self.email setBackgroundColor:lightGray];
    
    //username
    self.username = [[UITextField alloc] initWithFrame:CGRectMake(self.view.frame.size.width * 0.2, self.view.frame.size.height * 0.4, self.view.frame.size.width * 0.6, self.view.frame.size.height * 0.05)];
    [self.username setPlaceholder:@"username"];
    self.username.layer.cornerRadius = 5;
    [self.username setBackgroundColor:lightGray];
    
    //password
    self.password = [[UITextField alloc] initWithFrame:CGRectMake(self.view.frame.size.width * 0.2, self.view.frame.size.height * 0.5, self.view.frame.size.width * 0.6, self.view.frame.size.height * 0.05)];
    self.password.layer.cornerRadius = 5;
    [self.password setPlaceholder:@"password"];
    [self.password setBackgroundColor:lightGray];
    
    
    //reset password
    self.resetPassword = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width * 0.2, self.view.frame.size.height * 0.6, self.view.frame.size.width * 0.6, self.view.frame.size.height * 0.1)];
    [self.resetPassword setTitle:@"Reset Your Password" forState:UIControlStateNormal];
    [self.resetPassword addTarget:self action:@selector(resetPasswordPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.resetPassword setBackgroundColor:[UIColor blackColor]];
    [self.resetPassword.layer setCornerRadius:5.0];
    
    
    
    //sign up button
    self.signUp = [[UIButton alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height * 0.9, self.view.frame.size.width * 0.5, self.view.frame.size.height * 0.1)];
    //self.signUp.layer.cornerRadius = 5;
    [self.signUp.layer setBorderWidth:1.0];
    [self.signUp.layer setBorderColor:[[UIColor whiteColor] CGColor]]; //TODO: why is CG color added here
    [self.signUp setTitle:@"Sign Up!" forState:UIControlStateNormal];
    [self.signUp setBackgroundColor:[UIColor blackColor]];
     [self.signUp setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.signUp addTarget:self action:@selector(addUser) forControlEvents:UIControlEventTouchUpInside];
    
    //login
    self.loginButton = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width * 0.5, self.view.frame.size.height * 0.9, self.view.frame.size.width * 0.5, self.view.frame.size.height * 0.1)];
    //self.loginButton.layer.cornerRadius = 5;
    [self.loginButton.layer setBorderWidth:1.0];
    [self.loginButton.layer setBorderColor:[[UIColor whiteColor] CGColor]]; //TODO: why is CG color added here
    [self.loginButton setTitle:@"Login" forState:UIControlStateNormal];
    [self.loginButton setBackgroundColor:[UIColor blackColor]];
    [self.loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.loginButton addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    self.password.secureTextEntry = YES;
    
    
    
    
    [self.view addSubview:self.resetPassword];
    [self.view addSubview:self.loginButton];
    [self.view addSubview:self.signUp];
    [self.view addSubview:self.viewLabel];
    [self.view addSubview:self.username];
    [self.view addSubview:self.email];
    [self.view addSubview:self.password];
}//addElements

//MARK: did begin editing -- commented out for now for personal taste
/*
-(void) textFieldDidBeginEditing:(UITextField *)textField
{
    textField.text = @"";
}//clears text when user clicks on textfield
*/

-(void)login
{
    [PFUser logInWithUsernameInBackground:self.username.text password:self.password.text
                                    block:^(PFUser *user, NSError *error) {
                                        if (user)
                                        {
                                            //TODO: fix bug where you can't segue after creating an alert message
                                            
                                            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"success" message:@"you logged in" preferredStyle: UIAlertControllerStyleAlert];
                                            //We add buttons to the alert controller by creating UIAlertActions:
                                            UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault                                                                     handler:^(UIAlertAction * _Nonnull action) {
                                                [self performSegueWithIdentifier:@"toTable2" sender:self];
                                            }]; //You can use a block here to handle a press on this button
                                            [alertController addAction:actionOk];
                                            
                                            [self presentViewController:alertController animated:YES completion:nil];
                                            //performSegue
                                        }//if user is successful
                                        else
                                        {
                                            // The login failed. Check error to see why.
                                            //NSLog(@"Error logging in");
                                            //NSLog(@"error signing up");
                                            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"error"
                                                                                                                     message:@"problem loggin in"
                                                                                                              preferredStyle:UIAlertControllerStyleAlert];
                                            //We add buttons to the alert controller by creating UIAlertActions:
                                            UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                                                               style:UIAlertActionStyleDefault
                                                                                             handler:nil]; //You can use a block here to handle a press on this button
                                            [alertController addAction:actionOk];
                                            [self presentViewController:alertController animated:YES completion:nil];
                                        }//else - if login error
                                    }];
}//login

//method to add user to backend
//MARK: addUser
-(void)addUser
{
    NSLog(@"add user button pressed");
    self.user.username = self.username.text;
    self.user.email = self.email.text;
    self.user.password = self.password.text;
    
    
    if ([self.user.username isEqual: @""] || [self.user.password isEqual: @""] || [self.user.password isEqual: @""] || [self.user.username isEqual: NULL])
    {
        //make user re-enter info
        NSLog(@"user left an input empty");
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error"
                                                                                 message:@"please input a valid username/password"
                                                                          preferredStyle:UIAlertControllerStyleAlert];
        //We add buttons to the alert controller by creating UIAlertActions:
        UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                           style:UIAlertActionStyleDefault
                                                         handler:nil]; //You can use a block here to handle a press on this button
        [alertController addAction:actionOk];
        [self presentViewController:alertController animated:YES completion:nil];
        //NSLog(@"user successfully signed up");
    }//if login info is empty
    else
    {
        //otherwise login
        [self.user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (!error)
            {   // Hooray! Let them use the app now.
                //perform segue
                NSLog(@"success signing up");
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"success"
                                                                                         message:@"you signed up"
                                                                                  preferredStyle:UIAlertControllerStyleAlert];
                //We add buttons to the alert controller by creating UIAlertActions:
                UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                                   style:UIAlertActionStyleDefault
                                                                 handler:^(UIAlertAction * _Nonnull action) {
                                                                     [self performSegueWithIdentifier:@"toTable2" sender:self];
                                                                 }]; //block statement here (^) for okay button handler to segue to view
                [alertController addAction:actionOk];
                [self presentViewController:alertController animated:YES completion:nil];
                
//                [self performSegueWithIdentifier:@"toTable" sender:self];
                
            }//if no errors
            else
            {
                NSLog(@"error signing up");
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"error"
                                                                                         message:@"problem signing up"
                                                                                  preferredStyle:UIAlertControllerStyleAlert];
                //We add buttons to the alert controller by creating UIAlertActions:
                UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                                   style:UIAlertActionStyleDefault
                                                                 handler:nil]; //You can use a block here to handle a press on this button
                [alertController addAction:actionOk];
                [self presentViewController:alertController animated:YES completion:nil];
            }//else for if there was an error
        }];
    }//else statement
    
    //NSLog(@"username: %@\npassword: %@\nemail: %@",user.username, user.password, user.email);
    
}//addUser

//MARK: did recieve memory warning
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}//didRecieveMemoryWarning

//password reset
-(void)resetPasswordPressed
{
    //have a pop-up subview with a textfield to store the email
    self.popUp = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width * 0.1, self.view.frame.size.height * 0.15, self.view.frame.size.width * 0.8, self.view.frame.size.height * 0.65)];
    [self.popUp setBackgroundColor:[UIColor blackColor]];
    //[popUp setAlpha:0.5];
    [self.popUp.layer setCornerRadius:10.0];
    
    
    //textfield
    self.emailResetField = [[UITextField alloc] initWithFrame:CGRectMake(self.popUp.frame.size.width * 0.1, self.popUp.frame.size.height * 0.3, self.popUp.frame.size.width * 0.8, self.popUp.frame.size.height * 0.1)];
    [self.emailResetField setPlaceholder:@"email"];
    [self.emailResetField.layer setCornerRadius:10.0];
    [self.emailResetField setBackgroundColor:lightGray];
    
    //submit button
    UIButton *submit = [[UIButton alloc] initWithFrame:CGRectMake(self.popUp.frame.size.width * 0.2, self.popUp.frame.size.height * 0.7, self.popUp.frame.size.width * 0.6, self.popUp.frame.size.height * 0.1)];
    [submit.layer setCornerRadius:10.0];
    [submit setTitle:@"submit" forState:UIControlStateNormal];
    [submit setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [submit setBackgroundColor:[UIColor whiteColor]];
    [submit addTarget:self action:@selector(sendEmailToParse) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    [self.popUp addSubview:submit];
    [self.popUp addSubview:self.emailResetField];
    [self.view addSubview: self.popUp];
}//resetPasswordPressed

//for resetPasswordPressed method
-(void)sendEmailToParse
{
    NSLog(@"emailresetfield: %@", self.emailResetField.text);
    [PFUser requestPasswordResetForEmail:self.emailResetField.text];
    
    
    //alert user email has been sent to change password - use alert handlers with blocks
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Email Sent"
                                                                             message:@"If you do not recieve an email then no account exists for that email"
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    //We add buttons to the alert controller by creating UIAlertActions:
    UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction * _Nonnull action) {
                                                         [self.popUp removeFromSuperview];
                                                     }]; //block statement here (^) for okay button handler to segue to view
    [alertController addAction:actionOk];
    [self presentViewController:alertController animated:YES completion:nil];

}//sendEmailToParse



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
