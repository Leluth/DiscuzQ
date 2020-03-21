import 'package:flutter/material.dart';

import 'package:discuzq/states/scopedState.dart';
import 'package:discuzq/states/appState.dart';
import 'package:discuzq/ui/ui.dart';
import 'package:discuzq/widgets/appbar/appbar.dart';
import 'package:discuzq/widgets/users/userHomeDelegateCard.dart';
import 'package:discuzq/models/userModel.dart';

class UserHomeDelegate extends StatefulWidget {
  final UserModel user;

  UserHomeDelegate({Key key, @required this.user}) : super(key: key);

  @override
  _UserHomeDelegateState createState() => _UserHomeDelegateState();
}

class _UserHomeDelegateState extends State<UserHomeDelegate> {
  @override
  void setState(fn) {
    if (!mounted) {
      return;
    }

    super.setState(fn);
  }

  @override
  void initState() {
    super.initState();
    //print(widget.user.toString());
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => ScopedStateModelDescendant<AppState>(
      rebuildOnChange: false,
      builder: (context, child, state) => Scaffold(
            appBar: DiscuzAppBar(
              title: "${widget.user.username}的个人主页",
            ),
            backgroundColor: DiscuzApp.themeOf(context).scaffoldBackgroundColor,
            body: ListView(
              children: <Widget>[
                ///
                /// 用户信息卡片
                /// 用于显示粉丝数量
                /// 关注或取消
                UserHomeDelegateCard(
                  user: widget.user,
                ),
              ],
            ),
          ));
}