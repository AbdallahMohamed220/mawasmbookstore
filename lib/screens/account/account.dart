import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mawasmbookstore/providers/auth.dart';
import 'package:provider/provider.dart';

class AccountScreen extends StatelessWidget {
  static const routeName = 'account_screen';

  const AccountScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'حسابى',
          style: Theme.of(context).textTheme.headline2.copyWith(
                color: Colors.white,
                fontSize: ScreenUtil().setSp(30, allowFontScalingSelf: true),
              ),
        ),
      ),
      backgroundColor: Colors.grey[100],
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 50.h),
              CircleAvatar(
                radius: 45,
                child: Image.asset('assets/images/user.png'),
              ),
              SizedBox(height: 30.h),
              Container(
                width: 500.w,
                height: 420.h,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    SizedBox(height: 50.h),
                    UserData(
                      icon: Icons.person,
                      label: 'سم المستخدم : ',
                      data: 'Abdallah Mohamed',
                    ),
                    UserData(
                      icon: Icons.mail,
                      label: 'البريد الالكترونى  : ',
                      data: 'Abdallah@gmail.com',
                    ),
                    SizedBox(height: 40.h),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          UserAction(label: 'تعديل الحساب'),
                          UserAction(label: ' تسجيل الخروج'),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class UserAction extends StatelessWidget {
  String label;
  UserAction({
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        width: 200.w,
        height: 70.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Text(
          label,
          style: Theme.of(context).textTheme.headline2.copyWith(
                color: Theme.of(context).primaryColor,
                fontSize: ScreenUtil().setSp(24, allowFontScalingSelf: true),
              ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class UserData extends StatelessWidget {
  IconData icon;
  String label;
  String data;
  UserData({
    this.icon,
    this.data,
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        right: 15.0,
        bottom: 30,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Icon(
            icon,
            size: 40.h,
            color: Colors.white,
          ),
          SizedBox(width: 10.w),
          FittedBox(
            child: Text(
              label,
              style: Theme.of(context).textTheme.headline2.copyWith(
                    color: Colors.white,
                    fontSize:
                        ScreenUtil().setSp(30, allowFontScalingSelf: true),
                  ),
            ),
          ),
          FittedBox(
            child: Text(
              data,
              style: Theme.of(context).textTheme.headline2.copyWith(
                    color: Colors.white,
                    fontSize:
                        ScreenUtil().setSp(30, allowFontScalingSelf: true),
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
