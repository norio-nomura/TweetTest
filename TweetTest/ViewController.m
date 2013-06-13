//
//  ViewController.m
//  TweetTest
//

#import <Accounts/Accounts.h>
#import <Social/Social.h>
#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)tweet:(id)sender;
{
	ACAccountStore *accountStore = [[ACAccountStore alloc] init];
    ACAccountType *accountType = [accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
    [accountStore requestAccessToAccountsWithType:accountType options:nil completion:^(BOOL granted, NSError *error) {
        if(granted) {
            NSArray *accountsArray = [accountStore accountsWithAccountType:accountType];
			if ([accountsArray count] > 0) {
				// Grab the initial Twitter account to tweet from.
				ACAccount *twitterAccount = accountsArray[0];
				
                NSString *status = [[_textView text]stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                NSString *applicationId = [_applicationIdView text];
                NSDictionary *params = applicationId.length ? @{@"adc": @"phone", @"application_id":applicationId, @"status":status} : @{@"adc": @"phone", @"status":status};
                
                SLRequest *slRequest = [SLRequest requestForServiceType:SLServiceTypeTwitter
                                                          requestMethod:SLRequestMethodPOST
                                                                    URL:[NSURL URLWithString:@"https://api.twitter.com/1/statuses/update.json"]
                                                             parameters:params];
                [slRequest setAccount:twitterAccount];
                [slRequest performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error){
                    NSLog(@"statusCode: %d",[urlResponse statusCode]);
                }];
			}
        }
	}];
}

@end
