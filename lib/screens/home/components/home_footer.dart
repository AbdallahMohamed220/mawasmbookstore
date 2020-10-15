import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mawasmbookstore/screens/categories/categories.dart';
import 'package:mawasmbookstore/screens/login/login.dart';

class HomeFooter extends StatelessWidget {
  const HomeFooter({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: Size(750, 1334), allowFontScaling: true);
    return Container(
      child: Column(
        children: [
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 180.w,
                  height: 1,
                  color: Colors.grey[700],
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0, left: 8),
                  child: Text(
                    'هذا ليس كل شئ',
                    style: Theme.of(context).textTheme.headline2.copyWith(
                          color: Theme.of(context).primaryColor,
                          fontSize: ScreenUtil()
                              .setSp(30, allowFontScalingSelf: true),
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
                Container(
                  width: 180.w,
                  height: 1,
                  color: Colors.grey[900],
                ),
              ],
            ),
          ),
          SizedBox(height: 40.h),
          FittedBox(
            child: Text(
              'يمكنك اختيار اى من وسائل الدفع الامنة والسريعة \n المتوفرة فى المنصة ، ايضا يمكنك الحصول على \n طلباتك عند باب المنزل او الذهاب لاستلامه \n من منافذ البيع',
              style: Theme.of(context).textTheme.headline2.copyWith(
                    color: Colors.grey[600],
                    fontSize:
                        ScreenUtil().setSp(28, allowFontScalingSelf: true),
                  ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 30.h),
          GridView.count(
            crossAxisCount: 3,
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            padding: const EdgeInsets.all(10.0),
            mainAxisSpacing: 20.0,
            crossAxisSpacing: 50.0,
            childAspectRatio: 8 / 9.5,
            children: <Widget>[
              HomeCategoryItems(
                title: 'شولية خدمات \n الطباعة',
                imagePath: 'assets/icons/3d-print.png',
              ),
              HomeCategoryItems(
                title: 'سهولة استخدام \n التطبيق',
                imagePath: 'assets/icons/mobile.png',
              ),
              HomeCategoryItems(
                title: 'مطبوعاتك حسب \n رغبتك',
                imagePath: 'assets/icons/printer_one.png',
              ),
              HomeCategoryItems(
                title: 'اسعار منافسة',
                imagePath: 'assets/icons/price.png',
              ),
              HomeCategoryItems(
                title: 'سهولة الدفع',
                imagePath: 'assets/icons/credit-cards.png',
              ),
              HomeCategoryItems(
                title: 'تنوع طرق التوصيل ',
                imagePath: 'assets/icons/delivery-time.png',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class HomeCategoryItems extends StatelessWidget {
  String imagePath;
  String title;

  HomeCategoryItems({this.title, this.imagePath});

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: Size(750, 1334), allowFontScaling: true);
    return Column(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              border: Border.all(
                color: Theme.of(context).primaryColor,
              ),
              borderRadius: BorderRadius.circular(10)),
          child: Image.asset(
            imagePath,
            width: 50.w,
            height: 50.w,
          ),
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 15.0, right: 8),
            child: FittedBox(
              child: Text(
                title,
                style: Theme.of(context).textTheme.headline2.copyWith(
                      color: Colors.grey[600],
                      fontSize:
                          ScreenUtil().setSp(25, allowFontScalingSelf: true),
                      fontWeight: FontWeight.w600,
                    ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
