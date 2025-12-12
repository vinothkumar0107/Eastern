import 'package:eastern_trust/views/screens/home/widget/top_buttons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eastern_trust/core/route/route.dart';
import 'package:eastern_trust/core/utils/dimensions.dart';
import 'package:eastern_trust/core/utils/my_color.dart';
import 'package:eastern_trust/core/utils/style.dart';
import 'package:eastern_trust/core/utils/url.dart';
import 'package:eastern_trust/data/controller/home/home_controller.dart';
import 'package:eastern_trust/views/components/circle_widget/circle_image_button.dart';
import 'package:url_launcher/url_launcher.dart';
import 'balance_animated_app_bar.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HomeScreenTop extends StatefulWidget {
  const HomeScreenTop({Key? key}) : super(key: key);

  @override
  State<HomeScreenTop> createState() => _HomeScreenTopState();
}

class _HomeScreenTopState123 extends State<HomeScreenTop> {

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) => Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 8,
                child: GestureDetector(
                  onTap: (){
                    Get.toNamed(RouteHelper.profileScreen);
                  },
                  child: Row(
                    children: [
                      CircleImageWidget(
                        height:60,
                        width:60,
                        isProfile:true,
                        isAsset: false,
                        imagePath: '${UrlContainer.domainUrl}/assets/images/user/profile/${controller.imagePath}',
                        press: (){
                           Get.toNamed(RouteHelper.profileScreen);
                        },),
                      const SizedBox(width: Dimensions.space15),
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(controller.username, overflow:TextOverflow.ellipsis,textAlign: TextAlign.left, style: interRegularLarge.copyWith(color: MyColor.colorWhite, fontWeight: FontWeight.w800, fontSize: Dimensions.fontExtraLarge)),
                            const SizedBox(height: Dimensions.space5),
                            Text(controller.accountNumber, overflow:TextOverflow.ellipsis,textAlign: TextAlign.left, style: interRegularSmall.copyWith(fontSize:Dimensions.fontExtraSmall+3,fontWeight: FontWeight.w800, color: MyColor.colorWhite.withOpacity(.8))),
                            const SizedBox(height: Dimensions.space5),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: Dimensions.space10),
              Column(
                children: [
                  Row(
                    children: [
                      SizedBox(width:120,child: BalanceAnimationContainer(amount: controller.balance,curSymbol: controller.currencySymbol))
                    ],
                  )

                ],
              ),
              IconButton(
                icon: const Icon(Icons.notifications_none_sharp, color: Colors.white),
                onPressed: () {
                  Get.toNamed(RouteHelper.notificationScreen);
                },
              ),
            ],
          ),
          const SizedBox(height: Dimensions.space30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: controller.homeTopModuleList
                .map((widget) => Expanded(child: widget))
                .toList(),
          ),
        ],
      ),
    );
  }
}

class _HomeScreenTopState extends State<HomeScreenTop> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) {
        final modules = controller.homeTopModuleList;

        return Column(
          children: [
            // --- Top section (profile + balance + notification)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 8,
                  child: GestureDetector(
                    onTap: () {
                      Get.toNamed(RouteHelper.profileScreen);
                    },
                    child: Row(
                      children: [
                        CircleImageWidget(
                          height: 60,
                          width: 60,
                          isProfile: true,
                          isAsset: false,
                          imagePath:
                          '${UrlContainer.domainUrl}/assets/images/user/profile/${controller.imagePath}',
                          press: () {
                            Get.toNamed(RouteHelper.profileScreen);
                          },
                        ),
                        const SizedBox(width: Dimensions.space15),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                controller.username,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.left,
                                style: interRegularLarge.copyWith(
                                  color: MyColor.colorWhite,
                                  fontWeight: FontWeight.w800,
                                  fontSize: Dimensions.fontExtraLarge,
                                ),
                              ),
                              const SizedBox(height: Dimensions.space5),
                              Text(
                                controller.accountNumber,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.left,
                                style: interRegularSmall.copyWith(
                                  fontSize:
                                  Dimensions.fontExtraSmall + 3,
                                  fontWeight: FontWeight.w800,
                                  color:
                                  MyColor.colorWhite.withOpacity(.8),
                                ),
                              ),
                              const SizedBox(height: Dimensions.space5),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: Dimensions.space10),
                Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 120,
                          child: BalanceAnimationContainer(
                            amount: controller.balance,
                            curSymbol: controller.currencySymbol,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                IconButton(
                  icon: const Icon(Icons.notifications_none_sharp,
                      color: Colors.white),
                  onPressed: () {
                    Get.toNamed(RouteHelper.notificationScreen);
                  },
                ),
              ],
            ),

            // --- Show modules only if available
            if (modules.isNotEmpty) ...[
              const SizedBox(height: Dimensions.space25),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:
                modules.map((w) => Expanded(child: w)).toList(),
              ),
            ],
          ],
        );
      },
    );
  }
}

// Trading View Ticker
class TradingViewTicker extends StatelessWidget {
  const TradingViewTicker({super.key});

  final String html = """
  <html lang="">
    <head>
      <meta name="viewport" content="width=device-width, initial-scale=1.0">
      <style>
        html, body {
          margin: -2;
          padding: 0;
          overflow: hidden;
          background-color: #121212;
        }
        .trading-widget-container {
          width: 100%;
          height: 100%;
          background-color: #121212;
          border-radius: 1px;
        }
        iframe {
          transform: scale(1.0);
          transform-origin: left center;
        }
      </style>
    </head>
    <body>
      <div class="tradingview-widget-container">
        <div class="tradingview-widget-container__widget"></div>
        <script type="text/javascript" src="https://s3.tradingview.com/external-embedding/embed-widget-ticker-tape.js" async>
        {
          "symbols": [
            { "proName": "FOREXCOM:SPXUSD", "title": "S&P 500 Index" },
            { "proName": "FOREXCOM:NSXUSD", "title": "US 100 Cash CFD" },
            { "proName": "FX_IDC:EURUSD", "title": "EUR/USD" },
            { "proName": "BITSTAMP:BTCUSD", "title": "Bitcoin" },
            { "proName": "BITSTAMP:ETHUSD", "title": "Ethereum" }
          ],
          "showSymbolLogo": true,
          "isTransparent": false,
          "displayMode": "regular",
          "colorTheme": "light",
          "locale": "en"
        }
        </script>
      </div>
    </body>
  </html>
  """;

  // 👇 Change this to your desired external URL
  final String externalUrl = "https://www.tradingview.com/markets";

  Future<void> _openExternalBrowser() async {
    final uri = Uri.parse(externalUrl);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadHtmlString(html);

    return GestureDetector(
      onTap: _openExternalBrowser,
      child: Container(
        height: 40,
        decoration: BoxDecoration(
          color: MyColor.primaryColor,
          borderRadius: BorderRadius.circular(0),
        ),
        clipBehavior: Clip.hardEdge,
        child: IgnorePointer(
          ignoring: true, // disable interaction inside WebView
          child: WebViewWidget(controller: controller),
        ),
      ),
    );
  }
}

