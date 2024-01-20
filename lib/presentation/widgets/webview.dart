import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:students_payment_system/presentation/pages/home_page.dart';
import 'package:students_payment_system/utils/router/base_navigator.dart';

class WebViewWidget extends StatefulWidget {
  final dynamic data;
  const WebViewWidget({super.key, required this.data});

  @override
  State<WebViewWidget> createState() => _WebViewWidgetState();
}

class _WebViewWidgetState extends State<WebViewWidget> {
  final GlobalKey webViewKey = GlobalKey();
  late InAppWebViewController _webViewController;
  double progress = 0;
  String url = '';
  late PullToRefreshController pullToRefreshController;

  InAppWebViewSettings options = InAppWebViewSettings(
    useShouldOverrideUrlLoading: true,
    mediaPlaybackRequiresUserGesture: false,
    useHybridComposition: true,
    allowsInlineMediaPlayback: true,
    javaScriptEnabled: false,
  );

  @override
  void initState() {
    super.initState();
    pullToRefreshController = PullToRefreshController(
      settings: PullToRefreshSettings(color: Colors.blue),
      onRefresh: () async {
        if (Platform.isAndroid) {
          _webViewController.reload();
        } else if (Platform.isIOS) {
          _webViewController.loadUrl(
            urlRequest: URLRequest(url: await _webViewController.getUrl()),
          );
        }
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: widget.data['url'].contains('dojah')
          ? FloatingActionButton.extended(
              onPressed: () {
                BaseNavigator.key.currentState!.pushNamedAndRemoveUntil(
                  HomePage.routeName,
                  (route) => false,
                );
              },
              elevation: 0,
              label: const Text('Go to dashboard'),
            )
          : null,
      body: SafeArea(
        child: Column(
          children: [
            progress < 1.0
                ? LinearProgressIndicator(
                    value: progress,
                    backgroundColor: const Color(0xffD6D6D6),
                    valueColor:
                        const AlwaysStoppedAnimation<Color>(Colors.deepPurple),
                  )
                : Container(),
            Expanded(
              child: InAppWebView(
                key: webViewKey,
                initialUrlRequest: URLRequest(url: WebUri(widget.data['url'])),
                // initialSettings: options,
                pullToRefreshController: pullToRefreshController,
                // onWebViewCreated: (controller) {
                //   _webViewController = controller;
                // },
                onLoadStart: (controller, url) {
                  if (url.toString().contains("/${widget.data['cancelUrl']}")) {
                    if (Navigator.canPop(context)) {
                      Navigator.pop(context);
                    }
                  }
                },
                onPermissionRequest: (controller, resources) async {
                  return PermissionResponse(
                    resources: [],
                    action: PermissionResponseAction.GRANT,
                  );
                },
                onLoadStop: (controller, url) {
                  pullToRefreshController.endRefreshing();
                },
                onReceivedError: (controller, url, code) {
                  pullToRefreshController.endRefreshing();
                },
                onProgressChanged: (controller, progress) {
                  if (progress == 100) {
                    pullToRefreshController.endRefreshing();
                  }
                  setState(() {
                    this.progress = progress / 100;
                  });
                },
                onConsoleMessage: (controller, consoleMessage) {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyInAppBrowser extends InAppBrowser {
  @override
  Future onBrowserCreated() async {}

  @override
  Future onLoadStart(url) async {}

  @override
  Future onLoadStop(url) async {}

  @override
  void onLoadError(url, code, message) {}

  @override
  void onProgressChanged(progress) {}

  @override
  void onExit() {}
}

class MyChromeSafariBrowser extends ChromeSafariBrowser {
  @override
  void onOpened() {}

  @override
  void onClosed() {}
}
