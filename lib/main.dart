import 'dart:math';

import 'package:flutter/material.dart';
import 'package:petitparser/petitparser.dart';

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

class HomeView extends StatefulWidget {
  HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final CustomColor _customColor = CustomColor();

  String values = '';
  double answer = 0.0;
  List _history = [];

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
                  '${answer == 0.0 ? 0 : answer}',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 15,
                ),
      
                Text(
                  '$values',
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
                          action: () {
                            setState(() {
                              values = values + '7';
                            });
                          },
                        ),
                        KeyPadWidget(
                          customColor: _customColor,
                          label: '8',
                          action: () {
                            setState(() {
                              values = values + '8';
                            });
                          },
                        ),
                        KeyPadWidget(
                          customColor: _customColor,
                          label: '9',
                          action: () {
                            setState(() {
                              values = values + '9';
                            });
                          },
                        ),
                        OperatorKeyPadWidget(
                          operator: '+',
                          action: () {
                            if (values.isNotEmpty) {
                              values = values + ' + ';
                              setState(() {});
                              print(values);
                            }
                          },
                        )
                      ],
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        KeyPadWidget(
                          customColor: _customColor,
                          label: '4',
                          action: () {
                            setState(() {
                              values = values + '4';
                            });
                          },
                        ),
                        KeyPadWidget(
                          customColor: _customColor,
                          label: '5',
                          action: () {
                            setState(() {
                              values = values + '5';
                            });
                          },
                        ),
                        KeyPadWidget(
                          customColor: _customColor,
                          label: '6',
                          action: () {
                            setState(() {
                              values = values + '6';
                            });
                          },
                        ),
                        OperatorKeyPadWidget(
                          operator: '-',
                          action: () {
                            if (values.isNotEmpty) {
                              values = values + ' - ';
                              setState(() {});
                              print(values);
                            }
                          },
                        )
                      ],
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        KeyPadWidget(
                          customColor: _customColor,
                          label: '1',
                          action: () {
                            setState(() {
                              values = values + '1';
                            });
                          },
                        ),
                        KeyPadWidget(
                          customColor: _customColor,
                          label: '2',
                          action: () {
                            setState(() {
                              values = values + '2';
                            });
                          },
                        ),
                        KeyPadWidget(
                          customColor: _customColor,
                          label: '3',
                          action: () {
                            setState(() {
                              values = values + '3';
                            });
                          },
                        ),
                        OperatorKeyPadWidget(
                          operator: 'x',
                          action: () {
                            if (values.isNotEmpty) {
                              values = values + ' x ';
                              setState(() {});
                              print(values);
                            }
                            print('x');
                          },
                        )
                      ],
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        KeyPadWidget(
                          customColor: _customColor,
                          label: '0',
                          action: () {
                            if (values.isNotEmpty) {
                              setState(() {
                                values = values + '0';
                              });
                            }
                          },
                        ),
                        KeyPadWidget(
                          customColor: _customColor,
                          label: '.',
                          action: () {
                            if (values.isEmpty) {
                              values = values + '0.';
                            } else if (!values.contains('.')) {
                              values = values + '.';
                            }

                            setState(() {});
                          },
                        ),
                        KeyPadWidget(
                          customColor: _customColor,
                          label: '=',
                          action: () {
                            print(values);

                            Parser buildParser() {
                              final builder = ExpressionBuilder();
                              builder.group()
                                ..primitive((pattern('+-').optional() &
                                        digit().plus() &
                                        (char('.') & digit().plus())
                                            .optional() &
                                        (pattern('eE') &
                                                pattern('+-').optional() &
                                                digit().plus())
                                            .optional())
                                    .flatten('number expected')
                                    .trim()
                                    .map(num.tryParse))
                                ..wrapper(char('(').trim(), char(')').trim(),
                                    (left, value, right) => value);
                              builder
                                  .group()
                                  .prefix(char('-').trim(), (op, num a) => -a);
                              builder.group().right(char('^').trim(),
                                  (num a, op, num b) => pow(a, b));
                              builder.group()
                                ..left(char('x').trim(),
                                    (num a, op, num b) => a * b)
                                ..left(char('/').trim(),
                                    (num a, op, num b) => a / b);
                              builder.group()
                                ..left(char('+').trim(),
                                    (num a, op, num b) => a + b)
                                ..left(char('-').trim(),
                                    (num a, op, num b) => a - b);
                              return builder.build().end();
                            }

                            final parser = buildParser();

                            final result = parser.parse(values);

                            setState(() {
                              answer = double.parse('${result.value}');
                            });
                            print('parser: $result');
                            _history.add(values);
                            print(values.split(RegExp('[^+-x//]+')));

                            // List<String> v = values.split(RegExp('[^+-x//]+'));
                            // double ee = 0.0;
                            // for (var i = 0; i < v.length; i++) {
                            //   if (v[i] == '+') {
                            //     String prev = v[i - 1];
                            //     String next = v[i + 1];
                            //     ee += adder(firstVal: prev, lastVal: next);
                            //     v.replaceRange(0, 3, ['$ee']);
                            //     print('v $v');
                            //   } else if (v[i] == '-') {
                            //     String prev = v[i - 1];
                            //     String next = v[i + 1];
                            //     ee += subst(firstVal: prev, lastVal: next);
                            //     v.replaceRange(0, 3, ['$ee']);
                            //     print('v $v');
                            //   } else if (v[i] == 'x') {
                            //     String prev = v[i - 1];
                            //     String next = v[i + 1];
                            //     ee += multi(firstVal: prev, lastVal: next);
                            //     v.replaceRange(0, 3, ['$ee']);
                            //     print('v $v');
                            //   } else if (v[i] == '/') {
                            //     String prev = v[i - 1];
                            //     String next = v[i + 1];
                            //     ee += divi(firstVal: prev, lastVal: next);
                            //     v.replaceRange(0, 3, ['$ee']);
                            //     print('v $v');
                            //   }
                            // }

                            // if (values.isNotEmpty) {
                            //   if (values.contains('+')) {
                            //     List ans = values.split('+');
                            //     values = (double.parse(ans.first) +
                            //             double.parse(ans.last))
                            //         .toString();
                            //   } else if (values.contains('-')) {
                            //     List ans = values.split('-');
                            //     values = (double.parse(ans.first) -
                            //             double.parse(ans.last))
                            //         .toString();
                            //   } else if (values.contains('x')) {
                            //     List ans = values.split('x');
                            //     values = (double.parse(ans.first) *
                            //             double.parse(ans.last))
                            //         .toString();
                            //   } else if (values.contains('/')) {
                            //     List ans = values.split('/');
                            //     values = (double.parse(ans.first) /
                            //             double.parse(ans.last))
                            //         .toString();
                            //   }
                            //   print(values);
                            //   setState(() {
                            //     answer = double.parse(values);
                            //   });
                            // }
                          },
                        ),
                        OperatorKeyPadWidget(
                          operator: '/',
                          action: () {
                            if (values.isNotEmpty) {
                              values = values + ' / ';
                              setState(() {});
                              print(values);
                            }
                          },
                        )
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

  double adder({required String firstVal, String lastVal = '0'}) {
    double ans = double.parse(firstVal) + double.parse(lastVal);
    print('add ans: $ans');
    return ans;
  }

  double subst({required String firstVal, required String lastVal}) {
    double ans = double.parse(firstVal) - double.parse(lastVal);
    print('sub ans: $ans');
    return ans;
  }

  double multi({required String firstVal, required String lastVal}) {
    double ans = double.parse(firstVal) * double.parse(lastVal);
    print('multi ans: $ans');
    return ans;
  }

  double divi({required String firstVal, required String lastVal}) {
    double ans = double.parse(firstVal) / double.parse(lastVal);
    print('div ans: $ans');
    return ans;
  }
}

class OperatorKeyPadWidget extends StatelessWidget {
  const OperatorKeyPadWidget(
      {Key? key, required String operator, required Function action})
      : this.operator = operator,
        this.action = action,
        super(key: key);

  final String operator;
  final Function action;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: TextButton.styleFrom(
            padding: const EdgeInsets.all(15),
            backgroundColor: Colors.blue,
            shape: CircleBorder()),
        onPressed: () => action(),
        child: Text(
          operator,
          style: TextStyle(color: Colors.white, fontSize: 23),
        ));
  }
}

class KeyPadWidget extends StatelessWidget {
  const KeyPadWidget(
      {Key? key,
      required CustomColor customColor,
      required String label,
      required Function action})
      : _customColor = customColor,
        text = label,
        this.action = action,
        super(key: key);

  final CustomColor _customColor;
  final String text;
  final Function action;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: TextButton.styleFrom(
            padding: const EdgeInsets.all(15),
            backgroundColor:
                text == '=' ? Colors.cyan : _customColor.keypadColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20))),
        onPressed: () => action(),
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
