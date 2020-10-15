import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mawasmbookstore/constants/constants.dart';
import 'package:mawasmbookstore/providers/auth.dart';
import 'package:mawasmbookstore/screens/home/home.dart';
import 'package:mawasmbookstore/screens/login/login.dart';
import 'package:mawasmbookstore/share_widgets/rounded_button.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

class RegistrationScreen extends StatefulWidget {
  static const routeName = 'registration_screen';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool showSpinner = false;
  bool showPassword = false;

  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: Size(750, 1334), allowFontScaling: true);
    return Scaffold(
      backgroundColor: Colors.white,
      key: _scaffoldKey,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  SizedBox(
                    height: 50.h,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: deviceWidth * 0.03),
                    height: 300.h,
                    width: 300.w,
                    child: Image.asset('assets/images/logo.png'),
                  ),
                  SizedBox(
                    height: 60.h,
                  ),
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: TextFormField(
                      textAlign: TextAlign.right,
                      controller: _nameController,
                      style: TextStyle(color: Colors.black),
                      validator: (value) {
                        if (value.trim().isEmpty) {
                          return 'قيمة غير صحيحة';
                        }
                        if (value.trim().length <= 3) {
                          return 'قيمة غير صحيحة';
                        }
                        return null;
                      },
                      decoration: kTextfieldDecoration.copyWith(
                        hintText: 'اسم المستخدم',
                        prefixIcon: Icon(Icons.person),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: TextFormField(
                      textAlign: TextAlign.right,
                      controller: _emailController,
                      style: TextStyle(color: Colors.black),
                      validator: (value) {
                        if (value.trim().isEmpty) {
                          return 'قيمة غير صحيحة';
                        }
                        if (!value.trim().contains('@')) {
                          return 'قيمة غير صحيحة';
                        }
                        return null;
                      },
                      decoration: kTextfieldDecoration.copyWith(
                        hintText: 'البريد الالكترونى',
                        prefixIcon: Icon(Icons.mail),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: TextFormField(
                      textAlign: TextAlign.right,
                      controller: _passwordController,
                      obscureText: !showPassword,
                      style: TextStyle(color: Colors.black),
                      validator: (value) {
                        if (value.trim().isEmpty) {
                          return 'قيمة غير صحيحة';
                        }
                        if (value.trim().length <= 8) {
                          return 'قيمة غير صحيحة';
                        }
                        return null;
                      },
                      decoration: kTextfieldDecoration.copyWith(
                        hintText: 'كلمة المرور',
                        prefixIcon: Icon(Icons.lock),
                        suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                showPassword = !showPassword;
                              });
                            },
                            child: showPassword
                                ? Icon(Icons.visibility)
                                : Icon(Icons.visibility_off)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40.h,
                  ),
                  RoundButton(
                    color: Theme.of(context).primaryColor,
                    text: 'تسجيل',
                    onpress: () async {
                      if (!_formKey.currentState.validate()) {
                        return;
                      }
                      _formKey.currentState.save();
                      try {
                        setState(() {
                          showSpinner = true;
                        });

                        await Provider.of<Auth>(context, listen: false).signUp(
                          _nameController.text.trim(),
                          _emailController.text.trim(),
                          _passwordController.text.trim(),
                        );

                        setState(() {
                          showSpinner = false;
                        });

                        _scaffoldKey.currentState.showSnackBar(
                          new SnackBar(
                            content: new Text(
                              'تم انشاء حساب بنجاح',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline2
                                  .copyWith(
                                    color: Colors.white,
                                    fontSize: ScreenUtil()
                                        .setSp(20, allowFontScalingSelf: true),
                                  ),
                              textAlign: TextAlign.center,
                            ),
                            duration: Duration(seconds: 2),
                            backgroundColor: Theme.of(context).primaryColor,
                          ),
                        );
                        Future.delayed(Duration(seconds: 2), () {
                          Navigator.of(context)
                              .pushReplacementNamed(HomeScreen.routeName);
                        });
                      } catch (e) {
                        setState(() {
                          showSpinner = false;
                        });
                        _scaffoldKey.currentState.showSnackBar(
                          new SnackBar(
                            elevation: 0,
                            content: new Text(
                              e.toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .headline2
                                  .copyWith(
                                    color: Colors.white,
                                    fontSize: ScreenUtil()
                                        .setSp(20, allowFontScalingSelf: true),
                                  ),
                              textAlign: TextAlign.center,
                            ),
                            duration: Duration(seconds: 2),
                            backgroundColor: Theme.of(context).errorColor,
                          ),
                        );
                      }
                    },
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context)
                            .pushReplacementNamed(LoginScreen.routeName);
                      },
                      child: Container(
                        width: 350.w,
                        height: 30.h,
                        alignment: Alignment.center,
                        child: RichText(
                          text: new TextSpan(
                            text: ' لديك حساب ؟ ',
                            style: Theme.of(context)
                                .textTheme
                                .headline2
                                .copyWith(
                                  color: Colors.grey[600],
                                  fontSize: ScreenUtil()
                                      .setSp(22, allowFontScalingSelf: true),
                                ),
                            children: <TextSpan>[
                              new TextSpan(
                                text: 'تسجيل الدخول',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline2
                                    .copyWith(
                                      color: Color(0xff0089d1),
                                      fontSize: ScreenUtil().setSp(22,
                                          allowFontScalingSelf: true),
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
