//
//  WebViewController.m
//  Foodicorn
//
//  Created by Justin Haar on 4/16/15.
//  Copyright (c) 2015 Timothy Yeh. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController () <UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.activityIndicator.hidesWhenStopped = YES;

    NSURL *url = [NSURL URLWithString:self.yummly.detailInstructionsUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
    UIBarButtonItem *shareButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(shareToSocialMedia)];
    self.navigationController.navigationItem.rightBarButtonItem = shareButton;
}


-(void)shareToSocialMedia
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Sharing on Social Media" message:@"In order to share Recipe on your own Facebook account or other social media accounts, you must be logged in to your social media accounts via the device settings." delegate:self cancelButtonTitle:@"Okay" otherButtonTitles: nil];
    [alert show];

    NSArray *activityItems = @[@"Hey check out this great recipe I found! %@", self.yummly.detailInstructionsUrl];

    UIActivityViewController *activityController = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:nil];

    [self presentViewController:activityController animated:YES completion:nil];
}

-(void)webViewDidStartLoad:(UIWebView *)webView
{
    [self.activityIndicator startAnimating];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self.activityIndicator stopAnimating];
}

@end
