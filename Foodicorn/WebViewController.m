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

    self.title = self.name;

    self.activityIndicator.hidesWhenStopped = YES;

    NSURL *url = [NSURL URLWithString:self.webUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
}

-(void)webViewDidStartLoad:(UIWebView *)webView
{
    [self.activityIndicator startAnimating];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self.activityIndicator stopAnimating];
}

- (IBAction)onShareButtonTapped:(UIBarButtonItem *)sender
{
    NSMutableArray *sharingItems = [NSMutableArray new];
    NSString *message = @"Hey, checkout this recipe I found using FoodiCorn. Foodicorn allows you to search your favorite recipes with many unique filters and follow friends. Checkout the recipe and the app below. Enjoy!";
    NSURL *url = [NSURL URLWithString:self.webUrl];
    NSURL *imageUrl = [NSURL URLWithString:self.imageUrl];
    NSData *data = [NSData dataWithContentsOfURL:imageUrl];
    UIImage *image = [UIImage imageWithData:data];

    if (message) {
        [sharingItems addObject:message];
    }
    if (image) {
        [sharingItems addObject:image];
    }
    if (url) {
        [sharingItems addObject:url];
    }

    UIActivityViewController *activityController = [[UIActivityViewController alloc]initWithActivityItems:sharingItems applicationActivities:nil];
    [self presentViewController:activityController animated:YES completion:nil];
}
@end
