import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mawasmbookstore/providers/auth.dart';
import 'package:mawasmbookstore/providers/cart.dart';
import 'package:mawasmbookstore/providers/order.dart';
import 'package:mawasmbookstore/screens/categories_items/categories_items.dart';
import 'package:mawasmbookstore/screens/home/home.dart';
import 'package:mawasmbookstore/screens/login/login.dart';
import 'package:mawasmbookstore/screens/onboarding/onboarding.dart';
import 'package:mawasmbookstore/screens/online_services/bill_details.dart';
import 'package:mawasmbookstore/screens/product_details/product_details.dart';
import 'package:mawasmbookstore/screens/register/register.dart';
import 'package:mawasmbookstore/screens/splash/splash.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:responsive_framework/responsive_wrapper.dart';

// void main() {
//   runApp(
//     DevicePreview(
//       builder: (context) => MyApp(),
//     ),
//   );
// }
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    // ScreenUtil.init(context,
    //     designSize: Size(750, 1334), allowFontScaling: true);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Auth>.value(
          value: Auth(),
        ),
        ChangeNotifierProvider<Cart>.value(
          value: Cart(),
        ),
        ChangeNotifierProvider<Orders>.value(
          value: Orders(),
        ),
      ],
      child: Consumer<Auth>(builder: (ctx, auth, child) {
        return MaterialApp(
          // locale: DevicePreview.of(context).locale, // <--- /!\ Add the locale
          // builder: DevicePreview.appBuilder,

          title: 'MawasmBooStore',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primaryColor: Color(0xff0089d1),
            textTheme: GoogleFonts.tajawalTextTheme(textTheme).copyWith(
              headline1: GoogleFonts.tajawal(
                textStyle: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
              headline2: GoogleFonts.tajawal(
                textStyle: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[500],
                ),
              ),
            ),
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: auth.isAuth ? HomeScreen() : OnBoardingScreen(),

          routes: {
            LoginScreen.routeName: (context) => LoginScreen(),
            RegistrationScreen.routeName: (context) => RegistrationScreen(),
            HomeScreen.routeName: (context) => HomeScreen(),
            CategoriesItemsScreen.routeName: (context) =>
                CategoriesItemsScreen(),
            ProductDetailsScreen.routeName: (context) => ProductDetailsScreen(),
            BillDetailsScreen.routeName: (context) => BillDetailsScreen(),
          },
        );
      }),
    );
  }
}
