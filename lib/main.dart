import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: HomeView(),
    );
  }
}

class HomeView extends StatelessWidget {
  HomeView({Key? key}) : super(key: key);

  final CustomColor _customColor = CustomColor();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _customColor.backgroundColor,
      body: SafeArea(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  '320',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  '320',
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 18,
                      fontWeight: FontWeight.normal),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  '320',
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 18,
                      fontWeight: FontWeight.normal),
                ),
                Spacer(),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        KeyPadWidget(
                          customColor: _customColor,
                          label: '7',
                        ),
                        KeyPadWidget(
                          customColor: _customColor,
                          label: '8',
                        ),
                        KeyPadWidget(
                          customColor: _customColor,
                          label: '9',
                        ),
                        TextButton(
                            style: TextButton.styleFrom(
                                padding: const EdgeInsets.all(15),
                                backgroundColor: Colors.blue,
                                shape: CircleBorder()),
                            onPressed: () {},
                            child: Text(
                              '+',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 23),
                            ))
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class KeyPadWidget extends StatelessWidget {
  const KeyPadWidget(
      {Key? key, required CustomColor customColor, required String label})
      : _customColor = customColor,
        text = label,
        super(key: key);

  final CustomColor _customColor;
  final String text;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: TextButton.styleFrom(
            padding: const EdgeInsets.all(15),
            backgroundColor: _customColor.keypadColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20))),
        onPressed: () {},
        child: Text(
          text,
          style: TextStyle(color: Colors.white, fontSize: 23),
        ));
  }
}

class CustomColor {
  final Color backgroundColor = Color.fromRGBO(30, 38, 53, 1);
  final Color keypadColor = Color.fromRGBO(40, 51, 73, 1);
}
