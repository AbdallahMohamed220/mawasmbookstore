import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mawasmbookstore/constants/constants.dart';
import 'package:mawasmbookstore/screens/login/login.dart';
import 'package:mawasmbookstore/screens/online_services/bill_details.dart';
import 'package:mawasmbookstore/screens/pick_file/pick_file.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

// ignore: must_be_immutable
class OnlineServicesProductDetailsScreen extends StatefulWidget {
  static const routeName = 'product_details_screen';

  String title;
  String imageUrl;
  String price;
  int id;

  OnlineServicesProductDetailsScreen({
    this.title,
    this.imageUrl,
    this.price,
    this.id,
  });

  @override
  _OnlineServicesProductDetailsScreenState createState() =>
      _OnlineServicesProductDetailsScreenState();
}

class _OnlineServicesProductDetailsScreenState
    extends State<OnlineServicesProductDetailsScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  String _fileName;

  List<PlatformFile> _paths;

  String _directoryPath;

  String _extension;

  bool _loadingPath = false;

  bool _multiPick = false;

  FileType _pickingType = FileType.any;

  TextEditingController _controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool showSpinner = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() => _extension = _controller.text);
  }

  void _openFileExplorer() async {
    setState(() => _loadingPath = true);
    try {
      _directoryPath = null;
      _paths = (await FilePicker.platform.pickFiles(
        type: _pickingType,
        allowMultiple: _multiPick,
        allowedExtensions: (_extension?.isNotEmpty ?? false)
            ? _extension?.replaceAll(' ', '')?.split(',')
            : null,
      ))
          ?.files;
    } on PlatformException catch (e) {
      print("Unsupported operation" + e.toString());
    } catch (ex) {
      print(ex);
    }
    if (!mounted) return;
    setState(() {
      _loadingPath = false;
      _fileName = _paths != null ? _paths.map((e) => e.name).toString() : '...';
    });
  }

  List<String> _chooseServices = [
    "استفسار (+10 ر.س)",
    "طلب خدمة (+20 ر.س)",
  ];

  String currentServicesValue;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _subjectController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: Size(750, 1334), allowFontScaling: true);

    return Scaffold(
      key: _scaffoldKey,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Form(
          key: _formKey,
          child: Center(
            child: ListView(
              children: [
                Container(
                  width: 500.w,
                  height: 300.h,
                  child: Hero(
                    tag: widget.imageUrl,
                    child: Image.network(
                      widget.imageUrl,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                Center(
                  child: Text(
                    widget.title,
                    style: Theme.of(context).textTheme.headline2.copyWith(
                          color: Colors.grey[700],
                          fontSize: ScreenUtil()
                              .setSp(30, allowFontScalingSelf: true),
                        ),
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: Center(
                    child: Text(
                      '${widget.price} ر.س',
                      style: Theme.of(context).textTheme.headline2.copyWith(
                            color: Colors.grey[700],
                            fontSize: ScreenUtil()
                                .setSp(20, allowFontScalingSelf: true),
                          ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 50.0, bottom: 20.0),
                  child: Column(
                    children: <Widget>[
                      FlatButton.icon(
                        label: Text(
                          "ارفق ملف",
                          style: Theme.of(context).textTheme.headline2.copyWith(
                                color: Colors.white,
                                fontSize: ScreenUtil()
                                    .setSp(20, allowFontScalingSelf: true),
                              ),
                        ),
                        onPressed: () => _openFileExplorer(),
                        color: Theme.of(context).primaryColor,
                        icon: Icon(
                          Icons.upload_file,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: deviceWidth,
                  height: 50.h,
                  child: Builder(
                    builder: (BuildContext context) => _loadingPath
                        ? SizedBox()
                        : _directoryPath != null
                            ? ListTile(
                                title: Text('Directory path'),
                                subtitle: Text(_directoryPath),
                              )
                            : _paths != null
                                ? Container(
                                    padding:
                                        const EdgeInsets.only(bottom: 30.0),
                                    height: MediaQuery.of(context).size.height *
                                        0.50,
                                    child: Scrollbar(
                                        child: ListView.separated(
                                      itemCount:
                                          _paths != null && _paths.isNotEmpty
                                              ? _paths.length
                                              : 1,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        final bool isMultiPath =
                                            _paths != null && _paths.isNotEmpty;
                                        final String name = 'File $index: ' +
                                            (isMultiPath
                                                ? _paths
                                                    .map((e) => e.name)
                                                    .toList()[index]
                                                : _fileName ?? '...');
                                        final path = _paths
                                            .map((e) => e.path)
                                            .toList()[index]
                                            .toString();

                                        return ListTile(
                                          title: Text(
                                            name,
                                          ),
                                          subtitle: Text(path),
                                        );
                                      },
                                      separatorBuilder:
                                          (BuildContext context, int index) =>
                                              const Divider(),
                                    )),
                                  )
                                : const SizedBox(),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
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
                      decoration: onlineTextfieldDecoration.copyWith(
                        hintText: ' البريد الالكترونى',
                        prefixIcon: Icon(Icons.mail),
                      ),
                    ),
                  ),
                ),
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: _passwordController,
                      textAlign: TextAlign.right,
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
                      decoration: onlineTextfieldDecoration.copyWith(
                        hintText: 'كلمة المرور',
                        prefixIcon: Icon(Icons.lock),
                      ),
                    ),
                  ),
                ),
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      maxLines: 4,
                      textAlign: TextAlign.right,
                      controller: _subjectController,
                      style: TextStyle(color: Colors.black),
                      validator: (value) {
                        if (value.trim().isEmpty) {
                          return 'قيمة غير صحيحة';
                        }
                        if (value.trim().length <= 5) {
                          return 'قيمة غير صحيحة';
                        }
                        return null;
                      },
                      decoration: onlineTextfieldDecoration.copyWith(
                        hintText: 'المطلوب',
                      ),
                    ),
                  ),
                ),
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: FormField<String>(
                    builder: (FormFieldState<String> state) {
                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          padding: const EdgeInsets.all(10.0),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.grey[50],
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.grey[300],
                            ),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: DropdownButton<String>(
                                itemHeight: 50,
                                elevation: 0,
                                isExpanded: false,
                                hint: Text("اخترالخدمة"),
                                dropdownColor: Colors.grey[200],
                                iconEnabledColor: Colors.grey,
                                value: currentServicesValue,
                                isDense: true,
                                onChanged: (String newValue) {
                                  setState(() {
                                    currentServicesValue = newValue;

                                    state.didChange(newValue);
                                  });
                                },
                                items: _chooseServices.map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                InkWell(
                  onTap: () async {
                    print('hi');
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
                      print(_subjectController.text.trim());
                      print(currentServicesValue);
                      print(_fileName);
                      // await Provider.of<Auth>(context, listen: false).signIn(
                      //   _emailController.text.trim(),
                      //   _passwordController.text.trim(),
                      // );
                      setState(() {
                        showSpinner = false;
                      });

                      Future.delayed(Duration(seconds: 0), () {
                        Navigator.of(context)
                            .pushReplacementNamed(BillDetailsScreen.routeName);
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
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Container(
                      width: 150.w,
                      height: 100.h,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        'اكمل الطلب',
                        style: Theme.of(context).textTheme.headline2.copyWith(
                              color: Colors.white,
                              fontSize: ScreenUtil()
                                  .setSp(25, allowFontScalingSelf: true),
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
    );
  }
}
