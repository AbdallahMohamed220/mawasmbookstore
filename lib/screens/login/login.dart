import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:mawasmbookstore/constants/constants.dart';
import 'package:mawasmbookstore/providers/auth.dart';
import 'package:mawasmbookstore/screens/home/home.dart';
import 'package:mawasmbookstore/screens/register/register.dart';
import 'package:mawasmbookstore/share_widgets/rounded_button.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

var deviceWidth;
var deviceHeight;

class LoginScreen extends StatefulWidget {
  static const routeName = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  bool showSpinner = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool showPassword = false;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    deviceWidth = MediaQuery.of(context).size.width;
    deviceHeight = MediaQuery.of(context).size.height;
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
              padding:
                  EdgeInsets.symmetric(horizontal: ScreenUtil().setHeight(20)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  SizedBox(
                    height: ScreenUtil().setHeight(50),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    height: ScreenUtil().setHeight(300),
                    width: ScreenUtil().setWidth(300),
                    child: Image.asset('assets/images/logo.png'),
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(100),
                  ),
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: TextFormField(
                      controller: _emailController,
                      textAlign: TextAlign.right,
                      style: TextStyle(color: Colors.black),
                      validator: (value) {
                        if (value.trim().isEmpty) {
                          return 'قيمة غير صحيحة';
                        }
                        if (!value.trim().contains('@')) {
                          return 'البريد الالكترونى غير صحيح';
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
                    height: ScreenUtil().setHeight(40),
                  ),
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: TextFormField(
                      controller: _passwordController,
                      textAlign: TextAlign.right,
                      obscureText: !showPassword,
                      style: TextStyle(color: Colors.black),
                      validator: (value) {
                        if (value.trim().isEmpty) {
                          return 'قيمة غير صحيحة';
                        }
                        if (value.trim().length <= 8) {
                          return 'كلمة الرور اقل من 8 احرف';
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
                    height: ScreenUtil().setHeight(30),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      margin: EdgeInsets.only(
                        left: ScreenUtil().setHeight(10),
                      ),
                      width: ScreenUtil().setWidth(300),
                      height: ScreenUtil().setHeight(30),
                      child: FittedBox(
                        child: Text(
                          "هل نسيت كلمة المرور ؟",
                          style: Theme.of(context).textTheme.headline2.copyWith(
                                color: Colors.grey[600],
                                fontSize: ScreenUtil()
                                    .setSp(25, allowFontScalingSelf: true),
                              ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(30),
                  ),
                  RoundButton(
                    color: Theme.of(context).primaryColor,
                    text: 'دخول',
                    onpress: () async {
                      if (!_formKey.currentState.validate()) {
                        return;
                      }
                      _formKey.currentState.save();
                      try {
                        setState(() {
                          showSpinner = true;
                        });
                        print(_emailController.text.trim());
                        print(_passwordController.text.trim());
                        await Provider.of<Auth>(context, listen: false).signIn(
                          _emailController.text.trim(),
                          _passwordController.text.trim(),
                        );
                        setState(() {
                          showSpinner = false;
                        });

                        Future.delayed(Duration(seconds: 1), () {
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
                                        .setSp(15, allowFontScalingSelf: true),
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
                    height: ScreenUtil().setWidth(70),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context)
                            .pushReplacementNamed(RegistrationScreen.routeName);
                      },
                      child: Container(
                        width: ScreenUtil().setWidth(350),
                        height: ScreenUtil().setWidth(50),
                        alignment: Alignment.center,
                        child: RichText(
                          text: new TextSpan(
                            text: 'ليس لديك حساب ؟ ',
                            style: Theme.of(context)
                                .textTheme
                                .headline2
                                .copyWith(
                                  color: Colors.grey[600],
                                  fontSize: ScreenUtil()
                                      .setSp(25, allowFontScalingSelf: true),
                                ),
                            children: <TextSpan>[
                              new TextSpan(
                                text: 'انشاء حساب الان',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline2
                                    .copyWith(
                                      color: Color(0xff0089d1),
                                      fontSize: ScreenUtil().setSp(20,
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
