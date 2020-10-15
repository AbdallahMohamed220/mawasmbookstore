import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mawasmbookstore/screens/categories/categories.dart';
import 'package:mawasmbookstore/screens/categories_items/categories_items.dart';
import 'package:mawasmbookstore/screens/online_services/online_services.dart';
import 'package:mawasmbookstore/screens/print/print.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: GridView.count(
        crossAxisCount: 3,
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        padding: const EdgeInsets.all(4.0),
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 4.0,
        childAspectRatio: 1.2,
        children: <Widget>[
          HomeCategoryItems(
            title: 'المنتجات',
            imagePath: 'assets/icons/products.png',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CategoriesScreen('المنتجات'),
                ),
              );
            },
          ),
          HomeCategoryItems(
            title: 'طباعة الملفات',
            imagePath: 'assets/icons/printer.png',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PrintingScreen(),
                ),
              );
            },
          ),
          HomeCategoryItems(
            title: 'الخدمات الالكترونية',
            imagePath: 'assets/icons/charge.png',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      OnlineServicesCategoriesScreen('الخدمات الالكتروني'),
                ),
              );
            },
          ),
          HomeCategoryItems(
            title: 'ادوات مدرسية',
            imagePath: 'assets/icons/stationery.png',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      CategoriesItemsScreen(id: 133, title: 'ادوات مدرسية'),
                ),
              );
            },
          ),
          HomeCategoryItems(
            title: 'ادوات مكتبية',
            imagePath: 'assets/icons/book-shelf.png',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CategoriesItemsScreen(
                    id: 134,
                    title: 'ادوات مكتبية',
                  ),
                ),
              );
            },
          ),
          HomeCategoryItems(
            title: 'الكمبيوتر وملحقاته',
            imagePath: 'assets/icons/desktop-computer.png',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CategoriesItemsScreen(
                    id: 130,
                    title: 'الكمبيوتر وملحقاته',
                  ),
                ),
              );
            },
          ),
          HomeCategoryItems(
            title: 'القرطاسية والدفاتر',
            imagePath: 'assets/icons/desktop-computer.png',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CategoriesItemsScreen(
                    id: 167,
                    title: 'القرطاسية والدفاتر',
                  ),
                ),
              );
            },
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
  Function onTap;
  HomeCategoryItems({this.title, this.imagePath, this.onTap});

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: Size(750, 1334), allowFontScaling: true);
    return InkWell(
      onTap: onTap,
      child: Column(
        children: <Widget>[
          Image.asset(
            imagePath,
            width: 50.w,
            height: 50.w,
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: FittedBox(
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.headline2.copyWith(
                        color: Colors.grey[700],
                        fontSize:
                            ScreenUtil().setSp(25, allowFontScalingSelf: true),
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
