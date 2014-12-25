//
//  ViewController.m
//  AdcolonyV4VCWebViewApp
//
//  Created by Xiaofan Dai on 12/24/14.
//  Copyright (c) 2014 xiaofan.dai. All rights reserved.
//

#import "ViewController.h"
#import <AdColony/AdColony.h>
#import "Constants.h"

@interface ViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webview;

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
  _webview.delegate = self;
  NSString *filepath = [[NSBundle mainBundle] pathForResource:@"sample" ofType:@"html"];
  [_webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:filepath]]];
}
- (void) viewDidAppear:(BOOL)animated
{
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateCurrencyBalance) name:kCurrencyBalanceChange object:nil];
  
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(zoneReady) name:kZoneReady object:nil];
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(zoneOff) name:kZoneOff object:nil];
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(zoneLoading) name:kZoneLoading object:nil];
}

- (void)zoneReady {

}

- (void)zoneOff {

}

- (void)zoneLoading {

}

//notice webview video is finished
- (void)updateCurrencyBalance {
  [_webview stringByEvaluatingJavaScriptFromString:@"onAdcolonyCompleted();"];
}


-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
  if ([self showAdcolony:request]) {
    return NO;
  }else{
    return YES;
  }
}

-(BOOL)showAdcolony:(NSURLRequest *)request{
  if ([ request.URL.scheme isEqualToString:@"adcolony" ]) {
    [self triggerVideo];
    return YES;
  }
  
  return NO;
  
}

#pragma mark -
#pragma mark AdColony-specific
- (IBAction)triggerVideo
{
  [AdColony playVideoAdForZone:@"vzf8e4e97704c4445c87504e" withDelegate:nil withV4VCPrePopup:YES andV4VCPostPopup:YES];
}


- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
