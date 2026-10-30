import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() => runApp(const YousefFootballApp());

class YousefFootballApp extends StatelessWidget {
  const YousefFootballApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'YOUSEF FOOTBALL',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF07130F),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF20C878), brightness: Brightness.dark),
      ),
      home: const FootballHome(),
    );
  }
}

class FootballHome extends StatefulWidget {
  const FootballHome({super.key});
  @override
  State<FootballHome> createState() => _FootballHomeState();
}

class _FootballHomeState extends State<FootballHome> {
  late final WebViewController controller;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0xFF07130F))
      ..setNavigationDelegate(NavigationDelegate(
        onPageFinished: (_) => setState(() => loading = false),
      ))
      ..loadFlutterAsset('assets/game.html');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(children: [
          WebViewWidget(controller: controller),
          if (loading)
            const Center(child: CircularProgressIndicator(color: Color(0xFF20C878))),
        ]),
      ),
    );
  }
}