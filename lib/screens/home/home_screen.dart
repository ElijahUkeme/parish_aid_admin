import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:parish_aid_admin/features/home/app/bloc/home_bloc.dart';
import 'package:parish_aid_admin/features/home/app/bloc/home_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  InAppWebViewController? inAppWebViewController;
  PullToRefreshController? pullToRefreshController;
  late var url;
  var initialUrl = "https://www.parishaid.com/";
  var isLoading = false;

  @override
  void initState() {
    super.initState();
    pullToRefreshController = PullToRefreshController(
        onRefresh: () {
          inAppWebViewController!.reload();
        },
        options: PullToRefreshOptions(
            color: Colors.white, backgroundColor: Colors.black87));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
        ),
        body: Column(
          children: [
            Expanded(
                child: Stack(
              alignment: Alignment.center,
              children: [
                InAppWebView(
                  onLoadStart: (controller, urlParsed) {
                    isLoading = true;
                  },
                  onLoadStop: (controller, url) {
                    pullToRefreshController!.endRefreshing();
                    isLoading = false;
                  },
                  pullToRefreshController: pullToRefreshController,
                  onWebViewCreated: (controller) =>
                      inAppWebViewController = controller,
                  initialUrlRequest: URLRequest(url: WebUri(initialUrl)),
                ),
                Visibility(
                    visible: isLoading,
                    child: const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(Colors.grey),
                    ))
              ],
            ))
          ],
        ),
      );
    });
  }
}
