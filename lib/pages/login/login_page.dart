import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterfood/pages/homepage/home_page.dart';

import '../../main.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class LoginButton extends StatelessWidget {
  final int number;
  final Function(int) onClick;

  const LoginButton({
    Key? key,
    required this.number,
    required this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: number == -2 ? null : () => onClick(number),
      customBorder: CircleBorder(),
      child: Container(
        width: 80.0,
        height: 80.0,
        decoration: number == -2
            ? null
            : BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  width: 2.0,
                ),
              ),
        child: Center(
          child: number >= 0
              ? Text(
                  '$number',
                  style: Theme.of(context).textTheme.headline6,
                )
              : (number == -1
                  ? Icon(
                      Icons.backspace_outlined,
                      size: 28.0,
                    )
                  : SizedBox.shrink()),
        ),
      ),
    );
  }
}

class _LoginPageState extends State<LoginPage> {
  var input = '';

  void _showMaterialDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('ERROR!'),
          content: Column(
            children: [
              Text('Invaild PIN'),
            ],
          ),
          actions: [
            // ปุ่ม OK ใน dialog
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                // ปิด dialog
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _handleClickButton(int num) {
    //length

    setState(() {
      if (num == -1) {
        if (input.length > 0) input.substring(0, input.length - 1);
      } else {
        if (input.length < 6) {
          input = '$input$num';
        }
        if (input.length == 6) {
          if (input == '123456') {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => HomePage(
                        title: 'FLUTER FOOD',
                      )),
            );
          } else {
            _showMaterialDialog();
            input = '';
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.lock_outlined,
                        size: 100.0,
                      ),
                      Text(
                        "LOGIN",
                        style: Theme.of(context).textTheme.headline1,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (input.length > 0)
                                for (int i = 0; i < input.length; i++)
                                  if (i < 6)
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        width: 30.0,
                                        height: 30.0,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.pink,
                                          border: Border.all(
                                            width: 2.0,
                                          ),
                                        ),
                                      ),
                                    ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                //color: Colors.pink,
                child: Column(
                  children: [
                    [1, 2, 3],
                    [4, 5, 6],
                    [-2, 0, -1],
                  ].map((row) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: row.map((item) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: LoginButton(
                            number: item,
                            onClick: _handleClickButton,
                          ),
                        );
                      }).toList(),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
