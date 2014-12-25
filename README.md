Supporting Adcolony ads with WebView applications
============================

In order to support Adcolony ads within a WebView in native mobile applications, changes need to be made to have the application call Adcolony SDK to show Ads from links in webview.

**iOS**

With iOS, the delegate for the webview needs to be set:

    _webview.delegate = self;

Then the `webView:shouldStartLoadWithRequest:navigationType:` delegate method needs to be implemented so that it handles the links which you defined to trigger video:

    - (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
    {
      NSURL *requestURL = [request URL];
  
      if ([self showAdcolony:request]) {
        [[UIApplication sharedApplication] openURL:requestURL];
        return NO;
      }
      return YES;
    }

    -(BOOL)showAdcolony:(NSURLRequest *)request{
      if ([ request.URL.scheme isEqualToString:@"adcolony" ]) {
        [AdColony playVideoAdForZone:@"vzf8e4e97704c4445c87504e" withDelegate:nil withV4VCPrePopup:YES andV4VCPostPopup:YES];
        return YES;
      }
      
      return NO;
    }


