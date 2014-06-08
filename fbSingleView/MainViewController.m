//
//  MainViewController.m
//  fbSingleView
//
//  Created by Mario C. Delgado Jr. on 6/5/14.
//  Copyright (c) 2014 Mario C. Delgado Jr. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()
@property (weak, nonatomic) IBOutlet UIView *fbView;
@property (weak, nonatomic) IBOutlet UIView *viewbg;
@property (weak, nonatomic) IBOutlet UIView *textView;

@end

@implementation MainViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
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
