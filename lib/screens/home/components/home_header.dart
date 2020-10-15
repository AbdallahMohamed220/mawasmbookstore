import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mawasmbookstore/screens/login/login.dart';

class HomeHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: Size(750, 1334), allowFontScaling: true);

    return Container(
      width: 200.w,
      height: 200.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Text(
                'مكتبة مواسم',
                style: Theme.of(context).textTheme.headline2.copyWith(
                      color: Colors.grey[700],
                      fontSize:
                          ScreenUtil().setSp(35, allowFontScalingSelf: true),
                      fontWeight: FontWeight.bold,
                    ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          SizedBox(height: 30.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    FittedBox(
                      child: Text(
                        'مرحبا بك',
                        style: Theme.of(context).textTheme.headline2.copyWith(
                              color: Colors.grey[900],
                              fontSize: ScreenUtil()
                                  .setSp(30, allowFontScalingSelf: true),
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                    FittedBox(
                      child: Text(
                        'مكتبة مواسم لدينا جميع مستلماتك',
                        style: Theme.of(context).textTheme.headline2.copyWith(
                              color: Colors.grey[700],
                              fontSize: ScreenUtil()
                                  .setSp(30, allowFontScalingSelf: true),
                            ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15.0, left: 15),
                child: FittedBox(
                  child: Container(
                    width: 60.w,
                    height: 60.w,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/icons/profile.png'),
                      ),
                      shape: BoxShape.circle,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
