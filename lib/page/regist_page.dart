import 'package:dio/dio.dart' as dio;
import 'package:ap_03_luongquocdien/network/route/auth/auth_service.dart';
import 'package:flutter/material.dart';

class RegistPage extends StatefulWidget{
  const RegistPage({super.key});

  @override
  State<RegistPage> createState() => _RegistPage();
}

class _RegistPage extends State<RegistPage> {

  final _textUsernameController = TextEditingController();
  final _textPasswordController = TextEditingController();
  final _textConfirmPasswordController = TextEditingController();
  final _textFullnameController = TextEditingController();
  bool isContainUsername = false;
  bool isIncorrectPassword = false;
  bool isFullnameEmpty = false;
  bool isInvalidUsername = false;
  bool isInvalidPassword = false;
  AuthService? service;

  Future<void> register() async {
    if(_textFullnameController.text.isEmpty ||
        _textUsernameController.text.isEmpty ||
        _textPasswordController.text.length<6 ||
        _textPasswordController.text != _textConfirmPasswordController.text
    ){
      return;
    }
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              CircularProgressIndicator(),
            ],
          ),
        );
      },
    );
    Map<String,dynamic> body = {
      "username":_textUsernameController.text,
      "password":_textPasswordController.text,
      "fullname":_textFullnameController.text
    };
    final response = await service!.registAccount(body);
    Navigator.pop(context);
    if(response.error){
      setState(() {
        isContainUsername = true;
      });
    } else {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Đăng ký tài khoản thành công'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: const <Widget>[
                    Text('Bạn đã đăng ký tài khoản thành công. Hệ thống sẽ điều hướng bạn sang trang đăng nhập'),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text('Đã rõ',style: TextStyle(color: Colors.orange),),
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          }
      );
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    service = AuthService(dio.Dio());
    _textFullnameController.addListener(() {
      setState(() {
        isFullnameEmpty = _textFullnameController.text.isEmpty;
      });
    });
    _textUsernameController.addListener(() {
      setState(() {
        isInvalidUsername = _textUsernameController.text.isEmpty;
      });
    });
    _textPasswordController.addListener(() {
      isInvalidPassword = (_textPasswordController.text.length<6)?true:false;
    });
    _textConfirmPasswordController.addListener(() {
      isIncorrectPassword = (_textConfirmPasswordController.text != _textPasswordController.text)?true:false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 600,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Đăng ký",
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 60,
                  fontWeight: FontWeight.bold
                ),
              ),
              const Padding(padding: EdgeInsets.only(top: 30)),
              TextField(
                controller: _textFullnameController,
                decoration: const InputDecoration(
                  hintText: "Nhập họ tên",
                  labelText: "Họ tên",
                ),
              ),
              Visibility(
                  visible: isFullnameEmpty,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: const [
                      Text(
                        "Họ tên không được để trống!",
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 12
                        ),
                      ),
                    ],
                  )
              ),
              const Padding(padding: EdgeInsets.only(top: 30)),
              TextField(
                controller: _textUsernameController,
                decoration: const InputDecoration(
                  hintText: "Nhập tài khoản",
                  labelText: "Tài khoản",
                ),
              ),
              Visibility(
                visible: (isInvalidUsername)?true:(isContainUsername),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if(isContainUsername) const Text(
                      "Tài khoản này đã tồn tại! Vui lòng sử dụng tài khoản khác",
                      style: TextStyle(
                          color: Colors.red,
                          fontSize: 12
                      ),
                    ),
                    if(isInvalidUsername) const Text(
                      "Tài khoản không được để trống!",
                      style: TextStyle(
                          color: Colors.red,
                          fontSize: 12
                      ),
                    ),
                  ],
                )
              ),
              const Padding(padding: EdgeInsets.only(top: 20)),
              TextField(
                controller: _textPasswordController,
                obscureText: true,
                decoration: const InputDecoration(
                  hintText: "Nhập mật khẩu",
                  labelText: "Mật khẩu",
                ),
              ),
              const Padding(padding: EdgeInsets.only(top: 20)),
              TextField(
                controller: _textConfirmPasswordController,
                obscureText: true,
                decoration: const InputDecoration(
                  hintText: "Nhập mật khẩu",
                  labelText: "Nhập lại mật khẩu",
                ),
              ),
              Visibility(
                  visible: (isInvalidPassword)?true:(isIncorrectPassword),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      if(isIncorrectPassword) const Text(
                        "Mật khẩu nhập lại không chính xác!",
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 12
                        ),
                      ),
                      if(isInvalidPassword) const Text(
                        "Mật khẩu phải có ít nhất 6 ký tự!",
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 12
                        ),
                      ),
                    ],
                  )
              ),
              const Padding(padding: EdgeInsets.only(top: 30)),
              GestureDetector(
                onTap: (){
                  register();
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  decoration: const BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.all(Radius.circular(8))
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      Text(
                        "Đăng ký",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const Padding(padding: EdgeInsets.only(top: 25)),
              GestureDetector(
                onTap: (){
                  Navigator.pop(context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    Icon(Icons.arrow_back),
                    Text(
                      "Quay lại",
                      style: TextStyle(
                        fontSize: 17
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