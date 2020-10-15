import 'package:flutter/material.dart';
import 'package:mawasmbookstore/constants/constants.dart';
import 'package:mawasmbookstore/screens/login/login.dart';

class BillDetailsScreen extends StatefulWidget {
  static const routeName = 'bill_details_screen';
  BillDetailsScreen({Key key}) : super(key: key);
  @override
  _BillDetailsScreenState createState() => _BillDetailsScreenState();
}

class _BillDetailsScreenState extends State<BillDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('تفاصيل الفاتورة'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Directionality(
            textDirection: TextDirection.rtl,
            child: Container(
              width: deviceWidth * 0.5,
              height: deviceWidth * 0.5,
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[400]),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  _UserData(
                    label: 'البريد الالكترونى :',
                    data: 'test@test@gmail.com',
                  ),
                  _UserData(
                    label: 'كلمة المرور :',
                    data: '123456789',
                  ),
                  _UserData(
                    label: 'المطلوب :',
                    data: 'طباعة',
                  ),
                  _UserData(
                    label: 'نوع الخدمة :',
                    data: 'استفسار (+ 10 ر.س)',
                  ),
                  _UserData(
                    label: ' الاجمالى : ',
                    data: '10 ر.س',
                  ),
                ],
              ),
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.only(top: 15.0, right: 20),
          //   child: Directionality(
          //     textDirection: TextDirection.rtl,
          //     child: Text(
          //       'الدولة : ',
          //       style: Theme.of(context).textTheme.headline2.copyWith(
          //             color: Colors.grey[700],
          //             fontSize: 19,
          //           ),
          //     ),
          //   ),
          // ),
          // Directionality(
          //   textDirection: TextDirection.rtl,
          //   child: Padding(
          //     padding: const EdgeInsets.all(8.0),
          //     child: TextFormField(
          //       initialValue: 'المملكة العربية السعودية',
          //       readOnly: true,
          //       textAlign: TextAlign.right,
          //       style: TextStyle(color: Colors.black),
          //       decoration: onlineTextfieldDecoration,
          //     ),
          //   ),
          // ),
          // Padding(
          //   padding: const EdgeInsets.only(top: 15.0, right: 20),
          //   child: Directionality(
          //     textDirection: TextDirection.rtl,
          //     child: Text(
          //       'الدولة : ',
          //       style: Theme.of(context).textTheme.headline2.copyWith(
          //             color: Colors.grey[700],
          //             fontSize: 19,
          //           ),
          //     ),
          //   ),
          // ),
          // Directionality(
          //   textDirection: TextDirection.rtl,
          //   child: Padding(
          //     padding: const EdgeInsets.all(8.0),
          //     child: TextFormField(
          //       initialValue: 'المملكة العربية السعودية',
          //       readOnly: true,
          //       textAlign: TextAlign.right,
          //       style: TextStyle(color: Colors.black),
          //       decoration: onlineTextfieldDecoration,
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}

class _UserData extends StatelessWidget {
  String label;
  String data;
  _UserData({
    this.label,
    this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: 15.0,
            right: 15,
            bottom: 10,
          ),
          child: Text(
            label,
            style: Theme.of(context).textTheme.headline2.copyWith(
                  color: Colors.grey[700],
                  fontSize: 18,
                ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: 15.0,
            right: 8,
            bottom: 10,
          ),
          child: Text(
            data,
            style: Theme.of(context).textTheme.headline2.copyWith(
                  color: Colors.grey[700],
                  fontSize: 18,
                ),
          ),
        ),
      ],
    );
  }
}
