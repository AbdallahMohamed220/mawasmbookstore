import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mawasmbookstore/providers/auth.dart';
import 'package:mawasmbookstore/screens/account/account.dart';
import 'package:mawasmbookstore/screens/cart/cart.dart';
import 'package:mawasmbookstore/screens/home/components/home_body.dart';
import 'package:mawasmbookstore/screens/home/components/home_footer.dart';
import 'package:mawasmbookstore/screens/home/components/home_header.dart';
import 'package:mawasmbookstore/screens/login/login.dart';
import 'package:mawasmbookstore/screens/orders/orders.dart';
import 'package:mawasmbookstore/share_widgets/app_drawer.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:provider/provider.dart';
import 'package:woocommerce/woocommerce.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = 'home_screen';

  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool isAuth = false;
  PageController pageController;
  int pageIndex = 0;
  String baseUrl = "https://mawasmbookstore.com/";
  String consumerKey = "";
  String consumerSecret = "";

  List<WooProduct> products = [];
  List<WooProduct> featuredProducts = [];
  WooCommerce wooCommerce = WooCommerce(
    baseUrl: 'https://mawasmbookstore.com/',
    consumerKey: 'ck_c804ed805bfa25be8ecd694a27b46978ca64ade3',
    consumerSecret: 'cs_5557320ab49daf46a277d8aeed995988d369f4c5',
    isDebug: true,
  );

  getProducts() async {
    products = await wooCommerce.getProducts();
    setState(() {});
    print(products.toString());
  }

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: 3);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  onPageChanged(int pageIndex) {
    setState(() {
      this.pageIndex = pageIndex;
    });
  }

  onTap(int pageIndex) {
    pageController.animateToPage(
      pageIndex,
      duration: Duration(milliseconds: 200),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: Size(750, 1334), allowFontScaling: true);

    return Scaffold(
      body: PageView(
        children: <Widget>[
          AccountScreen(),
          OrdersScreen(),
          CartScreen(),
          ListView(
            children: [
              HomeHeader(),
              SizedBox(
                height: deviceWidth * 0.4,
                width: deviceWidth * 0.4,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Carousel(
                    images: [
                      NetworkImage(
                          'https://mawasmbookstore.com/wp-content/uploads/2020/09/2-3.jpg'),
                      NetworkImage(
                          'https://mawasmbookstore.com/wp-content/uploads/2020/09/%D8%AA%D8%B5%D9%85%D9%8A%D9%85-1.jpg'),
                      ExactAssetImage("assets/images/imageScroll1.jpeg"),
                      ExactAssetImage("assets/images/imageScroll2.jpeg"),
                    ],
                    dotSize: 10.0,
                    dotSpacing: 15.0,
                    boxFit: BoxFit.fill,
                    autoplayDuration: Duration(seconds: 5),
                    animationCurve: Curves.easeInOut,
                    dotColor: Colors.grey[400],
                    indicatorBgPadding: 8.0,
                    dotBgColor: Colors.transparent,
                    dotIncreasedColor: Theme.of(context).primaryColor,
                  ),
                ),
              ),
              SizedBox(height: 60.h),
              HomeBody(),
              HomeFooter()
            ],
          ),
        ],
        controller: pageController,
        onPageChanged: onPageChanged,
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: CupertinoTabBar(
        currentIndex: pageIndex,
        onTap: onTap,
        activeColor: Colors.yellow,
        items: [
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/icons/team.png',
              width: 50.w,
              height: 50.w,
            ),
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/icons/online-order.png',
              width: 50.w,
              height: 50.w,
            ),
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/icons/shopping-cart.png',
              width: 50.w,
              height: 50.w,
            ),
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/icons/home-office.png',
              width: 50.w,
              height: 50.w,
            ),
          ),
        ],
      ),
    );
  }
}
