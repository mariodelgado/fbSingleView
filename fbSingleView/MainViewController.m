//
//  MainViewController.m
//  fbSingleView
//
//  Created by Mario C. Delgado Jr. on 6/5/14.
//  Copyright (c) 2014 Mario C. Delgado Jr. All rights reserved.
//

#import "MainViewController.h"
#import "TTTAttributedLabel.h"

@interface MainViewController () <TTTAttributedLabelDelegate>

@property (weak, nonatomic) IBOutlet UIView *fbView;
@property (weak, nonatomic) IBOutlet UIView *viewbg;
@property (weak, nonatomic) IBOutlet UIView *textView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIButton *postButton;
@property (weak, nonatomic) IBOutlet UITextField *activeField;

@property (nonatomic, copy) NSString *fbDescription;

@property (nonatomic, weak) IBOutlet UILabel *attrLabel;



- (void)willShowKeyboard:(NSNotification *)notification;
- (void)willHideKeyboard:(NSNotification *)notification;

@end

@implementation MainViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willShowKeyboard:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willHideKeyboard:) name:UIKeyboardWillHideNotification object:nil];
        
        
        
    }
    return self;
}






- (void)viewDidLoad
{
    [super viewDidLoad];
        


    self.fbView.layer.cornerRadius = 5;
    self.navigationItem.title = @"Post";
    self.viewbg.layer.cornerRadius = 3;
    self.viewbg.layer.shadowColor = [UIColor colorWithRed:198/255.0f green:200/255.0f blue:204/255.0f alpha:1.0f].CGColor;
    self.viewbg.layer.shadowOffset = CGSizeMake(0, 0);
    self.viewbg.layer.shadowOpacity = 0.8;
    self.viewbg.layer.shadowRadius = 1;
    self.textView.layer.borderColor = [UIColor colorWithRed:198/255.0f green:200/255.0f blue:204/255.0f alpha:1.0f].CGColor;
    self.textView.layer.borderWidth = 1;
    
    
    // Link properties -
    UILabel *textLabel = self.attrLabel;
    UIColor *linkColor = [UIColor colorWithRed:0.203 green:0.329 blue:0.835 alpha:1];
    UIColor *linkActiveColor = [UIColor blackColor];
    
    // Detect links - Really wanted this to work, but for some reason it's not. :(
    if ([textLabel isKindOfClass:[TTTAttributedLabel class]])
    {
        TTTAttributedLabel *label = (TTTAttributedLabel *)textLabel;
        label.linkAttributes = @{NSForegroundColorAttributeName:linkColor,};
        label.activeLinkAttributes = @{NSForegroundColorAttributeName:linkActiveColor,};
        label.enabledTextCheckingTypes = NSTextCheckingTypeLink;
        label.delegate = self;
    }

    
    
    
    
    
    CGRect labelFrame = CGRectMake(25, 78, 280, 175);
    TTTAttributedLabel *label = [[TTTAttributedLabel alloc] initWithFrame:labelFrame];
    label.font = [UIFont systemFontOfSize:13];
    label.textColor = [UIColor blackColor];
    label.numberOfLines = 0;
    label.enabledTextCheckingTypes = NSTextCheckingTypeLink;

 
    //from TTTAttribuitedLabel
    NSString *text = @"From collarless shirts to high-waisted pants, #Her's costume designer, Casey Storm, explains how he created his fashion looks for the future: http://bit.ly/1jV9zM8";
    [label setText:text afterInheritingLabelAttributesAndConfiguringWithBlock:^ NSMutableAttributedString *(NSMutableAttributedString *mutableAttributedString) {
        NSRange boldRange = [[mutableAttributedString string] rangeOfString:@"#Her's" options:NSCaseInsensitiveSearch];
        NSRange linkRange = [[mutableAttributedString string] rangeOfString:@"http://bit.ly/1jV9zM8" options:NSCaseInsensitiveSearch];
        
        // Core Text APIs use C functions without a direct bridge to UIFont. See Apple's "Core Text Programming Guide" to learn how to configure string attributes.
        UIFont *boldSystemFont = [UIFont boldSystemFontOfSize:13];
        CTFontRef font = CTFontCreateWithName((__bridge CFStringRef)boldSystemFont.fontName, boldSystemFont.pointSize, NULL);
        if (font) {
            [mutableAttributedString addAttribute:(NSString *)kCTFontAttributeName value:(__bridge id)font range:boldRange];
           
            
        // Remove Underline??
            
          //  NSDictionary *linkAttributes = @{[NSNumber numberWithInt:kCTUnderlineStyleNone] : (id)kCTUnderlineStyleAttributeName};
          //  label.linkAttributes = linkAttributes;
            
            
            [label addLinkToURL:[NSURL URLWithString:@"http://bit.ly/1jV9zM8"] withRange:linkRange];
            CFRelease(font);
        }
        
        
        
        return mutableAttributedString;
    }];
    
    [self.fbView addSubview:label];

    
    
   }

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)shareAction:(id)sender
{
    NSArray *activityItems = nil;
    

    
    UIActivityViewController *activityController = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:nil];
    [self presentViewController:activityController animated:YES completion:nil];
}




- (void)willShowKeyboard:(NSNotification *)notification {
    NSDictionary *userInfo = [notification userInfo];
    
    // Get the keyboard height and width from the notification
    // Size varies depending on OS, language, orientation
    CGSize kbSize = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    NSLog(@"Height: %f Width: %f", kbSize.height, kbSize.width);
    
    // Get the animation duration and curve from the notification
    NSNumber *durationValue = userInfo[UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration = durationValue.doubleValue;
    NSNumber *curveValue = userInfo[UIKeyboardAnimationCurveUserInfoKey];
    UIViewAnimationCurve animationCurve = curveValue.intValue;
    
    // Move the view with the same duration and animation curve so that it will match with the keyboard animation
    [UIView animateWithDuration:animationDuration
                          delay:0.0
                        options:(animationCurve << 16)
                     animations:^{
                         self.textView.frame = CGRectMake(0, self.view.frame.size.height - kbSize.height + 55 - self.textView.frame.size.height, self.textView.frame.size.width, self.textView.frame.size.height);
                     }
                     completion:nil];
}

- (void)willHideKeyboard:(NSNotification *)notification {
    NSDictionary *userInfo = [notification userInfo];
    
    // Get the animation duration and curve from the notification
    NSNumber *durationValue = userInfo[UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration = durationValue.doubleValue;
    NSNumber *curveValue = userInfo[UIKeyboardAnimationCurveUserInfoKey];
    UIViewAnimationCurve animationCurve = curveValue.intValue;
    
    // Move the view with the same duration and animation curve so that it will match with the keyboard animation
    [UIView animateWithDuration:animationDuration
                          delay:0.0
                        options:(animationCurve << 16)
                     animations:^{
                         self.textView.frame = CGRectMake(0, self.view.frame.size.height  + 6 -  self.textView.frame.size.height, self.textView.frame.size.width, self.textView.frame.size.height);
                     }
                     completion:nil];
}

-(IBAction)cancelEditingForView:(id)sender {
    [[self view] endEditing:YES];
}



-(void) touchesEnded: (NSSet *) touches withEvent: (UIEvent *) event

{
    // Pass to parent
    
    [super touchesEnded:touches withEvent:event];
    [self.nextResponder touchesEnded:touches withEvent:event];
}

- (void)attributedLabel:(TTTAttributedLabel *)label didSelectLinkWithURL:(NSURL *)url
{
    // Open link in Safari
    [[UIApplication sharedApplication] openURL:url];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
