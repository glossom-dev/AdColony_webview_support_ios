WebView アプリケーションでAdcolonyの広告を表示する方法(iOS)
============================

WebView のネイティブ アプリケーションでAdcolonyの動画を表示する場合、ウェブページにあるリンクをクリックした後に動画を再生するため、下記のような修正が必要です。

**iOS**

iOSの場合、 広告が表示されたWebViewのdelegateを設定してください:

    _webview.delegate = self;

定義した動画再生のURLをクリックされたとき、処理するために、`webView:shouldStartLoadWithRequest:navigationType:` delegateメソッドを実装して、SDKの動画再生APIを呼んで動画を再生してください。

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


