import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../providers/cart.dart';

class CartItemWidget extends StatelessWidget {
  final String id;
  final String title;
  final String productId;
  final String imgUrl;
  final double price;
  final int quantity;

  const CartItemWidget({
    this.id,
    this.productId,
    this.imgUrl,
    this.quantity,
    this.price,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        print(productId);
        print(id);
        Provider.of<Cart>(context, listen: false).removeSingleItem(productId);
      },
      confirmDismiss: (direction) {
        return showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
                  content: Text(
                    'هل انت متأكد من مسح المنتج؟ ',
                    style: Theme.of(context).textTheme.headline2.copyWith(
                          color: Theme.of(context).primaryColor,
                          fontSize: ScreenUtil()
                              .setSp(24, allowFontScalingSelf: true),
                        ),
                  ),
                  actions: <Widget>[
                    FlatButton(
                      child: Text(
                        'الغاء',
                        style: Theme.of(context).textTheme.headline2.copyWith(
                              color: Theme.of(context).errorColor,
                              fontSize: ScreenUtil()
                                  .setSp(24, allowFontScalingSelf: true),
                            ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    FlatButton(
                      child: Text(
                        'تم',
                        style: Theme.of(context).textTheme.headline2.copyWith(
                              color: Theme.of(context).primaryColor,
                              fontSize: ScreenUtil()
                                  .setSp(24, allowFontScalingSelf: true),
                            ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop(true);
                      },
                    ),
                  ],
                ));
      },
      key: Key(UniqueKey().toString()),
      background: Container(
        color: Theme.of(context).errorColor,
        child: Icon(
          Icons.delete,
          size: 30,
          color: Colors.white,
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
      ),
      child: Card(
        elevation: 1,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        margin: EdgeInsets.all(5),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: ListTile(
            leading: Container(
                child: CircleAvatar(
              radius: 40.h,
              backgroundImage: NetworkImage(imgUrl),
            )),
            title: Text(title),
            subtitle: Text('الاجمالى: \$${price * quantity}'),
            trailing: Text("$quantity x"),
          ),
        ),
      ),
    );
  }
}
