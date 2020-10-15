import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:mawasmbookstore/screens/login/login.dart';

class OnBoardingScreen extends StatefulWidget {
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => LoginScreen()),
    );
  }

  Widget _buildImage(String assetName, BuildContext context) {
    ScreenUtil.init(context,
        designSize: Size(750, 1334), allowFontScaling: true);
    return Align(
      child: Image.asset(
        'assets/images/$assetName.png',
        height: 200.h,
        width: 400.0.w,
      ),
      alignment: Alignment.bottomCenter,
    );
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: Size(750, 1334), allowFontScaling: true);

    TextStyle bodyStyle = TextStyle(fontSize: 19.0);
    PageDecoration pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(
          fontSize: ScreenUtil().setSp(28, allowFontScalingSelf: true),
          fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white24,
      imagePadding: EdgeInsets.zero,
    );

    return IntroductionScreen(
      key: introKey,
      pages: [
        PageViewModel(
          titleWidget: Text(
            "مرحبا بك",
            style: Theme.of(context).textTheme.headline2.copyWith(
                  color: Colors.grey[700],
                  fontSize: ScreenUtil().setSp(30, allowFontScalingSelf: true),
                ),
          ),
          bodyWidget: Text(
            'تطبيق مواسم منذ عام 2000 ونحن نقدم منتجات\n المكتبات وخدمات الطباعة والخدمات الالكترونية لعملائنا',
            style: Theme.of(context).textTheme.headline2.copyWith(
                  color: Colors.grey[700],
                  fontSize: ScreenUtil().setSp(30, allowFontScalingSelf: true),
                ),
            textAlign: TextAlign.center,
          ),
          image: _buildImage('onborading1', context),
          decoration: pageDecoration,
        ),
        PageViewModel(
          titleWidget: Text(
            "مكتبة مواسم",
            style: Theme.of(context).textTheme.headline2.copyWith(
                  color: Colors.grey[700],
                  fontSize: ScreenUtil().setSp(30, allowFontScalingSelf: true),
                ),
          ),
          bodyWidget: Text(
            'ادواتك المكتبية كلها فى مكان واحد \n اقتنى احتيجاتك من مكان واحد',
            style: Theme.of(context).textTheme.headline2.copyWith(
                  color: Colors.grey[700],
                  fontSize: ScreenUtil().setSp(30, allowFontScalingSelf: true),
                ),
            textAlign: TextAlign.center,
          ),
          image: _buildImage('onborading2', context),
          decoration: pageDecoration,
        ),
        PageViewModel(
          titleWidget: Text(
            "مكتبة مواسم",
            style: Theme.of(context).textTheme.headline2.copyWith(
                  color: Colors.grey[700],
                  fontSize: ScreenUtil().setSp(30, allowFontScalingSelf: true),
                ),
          ),
          bodyWidget: Text(
            'مواسم اجعل المكتبة فى جوالك \n وانت فى مكانك ادفع اونلاين نصلك حيثما كنت \n نحن هنا من اجلك',
            style: Theme.of(context).textTheme.headline2.copyWith(
                  color: Colors.grey[700],
                  fontSize: ScreenUtil().setSp(30, allowFontScalingSelf: true),
                ),
            textAlign: TextAlign.center,
          ),
          image: _buildImage('onborading3', context),
          decoration: pageDecoration,
        ),
      ],
      onDone: () => _onIntroEnd(context),
      //onSkip: () => _onIntroEnd(context), // You can override onSkip callback
      showSkipButton: true,
      skipFlex: 0,
      nextFlex: 0,
      skip: Text('تخطى'),
      next: Icon(Icons.arrow_forward),
      done: Text(
        'تم',
        style: Theme.of(context).textTheme.headline2.copyWith(
              color: Colors.grey[600],
              fontSize: ScreenUtil().setSp(25, allowFontScalingSelf: true),
            ),
      ),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Color(0xFFBDBDBD),
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
    );
  }
}
