// ignore_for_file: file_names

import 'dart:convert';
import 'package:testing/Features/OrderScreen/OrderScreenController/OrdersControllerPagination.dart';
import 'package:testing/utils/Const/constValue.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:testing/utils/CustomColors/Customcolors.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:testing/utils/Const/ApiConstvariables.dart'; // For UserId

class Parcelchatbot extends StatefulWidget {
  const Parcelchatbot({super.key});

  @override
  State<Parcelchatbot> createState() => _ChatbotState();
}
class _ChatbotState extends State<Parcelchatbot> with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  bool isExpanded = false;
  bool isKeyboardVisible = false;
  double keyboardHeight = 0;

  late final WebViewController _webViewController;
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    final jsonInfoMap = {
      "data": {
        "email": useremail,
        "mobileNo": mobilenumb,
        "userId": UserId,
        "userName": username,
      },
      "token": Usertoken,
    };
    final jsonInfoJS = jsonEncode(jsonInfoMap);

    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (url) => debugPrint('Loading: $url'),
          onPageFinished: (url) async {
            await _webViewController.runJavaScript('''
              (function() {
                console.log = function () {};
                console.warn = function () {};
                console.error = function () {};
                var meta = document.createElement('meta');
                meta.name = 'viewport';
                meta.content = 'width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no';
                document.head.appendChild(meta);

                var style = document.createElement('style');
                style.innerHTML = '* { touch-action: manipulation; }';
                document.head.appendChild(style);

                localStorage.setItem('consumerId', "$UserId");
                localStorage.setItem('consumerInfo', JSON.stringify($jsonInfoJS));
                localStorage.setItem('token', "$Usertoken");
                localStorage.setItem('latitude', "$initiallat");
                localStorage.setItem('longitude', "$initiallong");
              })();
            ''');
          },
        ),
      )
      ..loadRequest(Uri.parse('https://chat.aloinfotech.in/'));

    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _scaleAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _controller.dispose();
    super.dispose();
  }

  void toggleChat() {
    setState(() {
      isExpanded = !isExpanded;
      isExpanded ? _controller.forward() : _controller.reverse();
    });
  }

  Widget buildExpandedChat() {
    
    return Container(
      width: MediaQuery.of(context).size.width / 1.2,
      height: MediaQuery.of(context).size.height * 0.55,
      
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [BoxShadow(blurRadius: 8, color: Colors.black26)],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: WebViewWidget(controller: _webViewController),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //final ordersProvider = Provider.of<GetOrdersProvider>(context);
  
   

  final bottomOffset = isKeyboardVisible
      ? keyboardHeight + 20
       : 130.h;


    return Stack(
      children: [
        // Floating chatbot icon
        Positioned(
          // bottom: 150.h,
          bottom: 75.h,
        // bottom: 150,
          right: 20,
          child: buildFloatingIcon(),
        ),

        // Chat window
        AnimatedPositioned(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
          bottom: isExpanded ? bottomOffset : -500,
        //  bottom: 200,
          right: 20,
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: isExpanded ? buildExpandedChat() : const SizedBox.shrink(),
          ),
        ),
      ],
    );
  }

  Widget buildFloatingIcon() {
    return GestureDetector(
      onTap: toggleChat,
      child: Container(
        width: 50.w,
        height: 50.h,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Customcolors.lightpurple,
            Customcolors.darkpurple],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Center(
          child: isExpanded
              ? const Icon(Icons.close, color: Colors.white, size: 26)
              : Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Image.asset(
                    "assets/images/chatbot_avatar.png",
                    fit: BoxFit.contain,
                  ),
                ),
        ),
      ),
    );
  }
}