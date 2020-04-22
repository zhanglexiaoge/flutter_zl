import 'package:flutter/material.dart';
import 'package:zlapp/commWidgets/commWidgets.dart';
import 'package:zlapp/_const/const.dart';
class SetPage extends StatefulWidget {
  @override
  _SetPageState createState() => _SetPageState();
}

class _SetPageState extends State<SetPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colours.color_f5f5,
        appBar:CommWidgets.getCommonAppBar(context, '设置'),
    );
  }
}
