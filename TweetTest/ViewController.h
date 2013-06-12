//
//  ViewController.h
//  TweetTest
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITextView *textView;
@property (strong, nonatomic) IBOutlet UITextView *applicationIdView;
- (IBAction)tweet:(id)sender;

@end
