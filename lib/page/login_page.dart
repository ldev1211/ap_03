import 'package:ap_03_luongquocdien/network/route/auth/auth_service.dart';
import 'package:ap_03_luongquocdien/page/main_page.dart';
import 'package:ap_03_luongquocdien/page/regist_page.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart' as dio;
import 'package:ap_03_luongquocdien/main.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {

  final _textUsernameController = TextEditingController();
  final _textPasswordController = TextEditingController();
  AuthService? service;

  Future<void> login() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              CircularProgressIndicator()
            ],
          )
        );
      },
    );
    Map<String,dynamic> body = {
      "username":_textUsernameController.text,
      "password":_textPasswordController.text
    };
    final response = await service!.login(body);
    Navigator.pop(context);
    if(response.error){
      // await player.pause();
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Trạng thái đăng nhập:'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: const <Widget>[
                    Text('Tài khoản hoặc mật khẩu của bạn không chính xác.'),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text('Đã rõ',style: TextStyle(color: Colors.orange),),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          }
      );
    } else {
      shared.setString("accessToken", response.data!.accessToken);
      shared.setString("fullName", response.data!.fullName);
      Navigator.push(context, MaterialPageRoute(builder: (context)=> const MainPageProvider()));
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    service = AuthService(dio.Dio());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 600,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(100))
                    ),
                    child: const Image(image: AssetImage("images/logo_ptit.png"),width: 90,height: 90,),
                  ),
                  const Padding(padding: EdgeInsets.only(right: 50)),
                  Container(
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(100))
                    ),
                    child: const Image(image: AssetImage("images/logo_multi.png"),width: 100,height: 100,),
                  )
                ],
              ),
              const Text(
                "Đăng nhập",
                style: TextStyle(
                    color: Colors.red,
                    fontSize: 60,
                    fontWeight: FontWeight.bold
                ),
              ),
              const Padding(padding: EdgeInsets.only(top: 20)),
              TextField(
                controller: _textUsernameController,
                decoration: const InputDecoration(
                  hintText: "Nhập tài khoản",
                  labelText: "Tài khoản",
                ),
              ),
              const Padding(padding: EdgeInsets.only(top: 30)),
              TextField(
                controller: _textPasswordController,
                onSubmitted: (stringSearch){
                  login();
                },
                textInputAction: TextInputAction.go,
                obscureText: true,
                decoration: const InputDecoration(
                  hintText: "Nhập mật khẩu",
                  labelText: "Mật khẩu",
                ),
              ),
              const Padding(padding: EdgeInsets.only(top: 50)),
              GestureDetector(
                onTap: (){
                  login();
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
                        "Đăng nhập",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const Padding(padding: EdgeInsets.only(top: 12)),
              const Text(
                "Bạn chưa có tài khoản?",
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 18
                ),
              ),
              const Padding(padding: EdgeInsets.only(top: 12)),
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const RegistPage()));
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.red),
                      borderRadius: const BorderRadius.all(Radius.circular(8))
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      Text(
                        "Đăng ký",
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 20
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}