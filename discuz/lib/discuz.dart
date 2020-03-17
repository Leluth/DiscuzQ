import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_sfsymbols/flutter_sfsymbols.dart';
import 'package:scoped_model/scoped_model.dart';

import 'package:discuzq/utils/global.dart';
import 'package:discuzq/models/appModel.dart';
import 'package:discuzq/ui/ui.dart';
import 'package:discuzq/views/accountDelegate.dart';
import 'package:discuzq/views/forumDelegate.dart';
import 'package:discuzq/views/searchThreadDelegate.dart';
import 'package:discuzq/widgets/bottomNavigator/bottomNavigator.dart';

class Discuz extends StatefulWidget {
  const Discuz({Key key}) : super(key: key);

  @override
  _DiscuzState createState() => _DiscuzState();
}

class _DiscuzState extends State<Discuz> {
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
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<AppModel>(
        rebuildOnChange: true,
        builder: (context, child, model) {
          return DiscuzApp(
            theme: _buildTheme(model),
            child: MaterialApp(
              title: Global.appname,
              debugShowCheckedModeBanner: false,
              home: Builder(

                  /// 不在 MaterialApp 使用theme属性
                  /// 这里rebuild的时候会有问题，所以使用Theme去包裹
                  /// 其实在MaterialApp里直接用theme也可以，但是flutter rebuild的时候有BUG， scaffoldBackgroundColor并未更新
                  /// 这样会造成黑暗模式切换时有问题
                  builder: (BuildContext context) => Theme(
                        data: ThemeData(
                            primaryColor:
                                DiscuzApp.themeOf(context).primaryColor,
                            splashColor: DiscuzApp.themeOf(context).splashColor,
                            highlightColor:
                                DiscuzApp.themeOf(context).highlightColor,
                            backgroundColor:
                                DiscuzApp.themeOf(context).backgroundColor,
                            scaffoldBackgroundColor: DiscuzApp.themeOf(context)
                                .scaffoldBackgroundColor,
                            canvasColor: DiscuzApp.themeOf(context)
                                .scaffoldBackgroundColor),
                        child: MediaQuery(
                          data: MediaQuery.of(context).copyWith(
                              boldText: false,
                              textScaleFactor:
                                  model.appConf['fontWidthFactor']),
                          child: const _DiscuzAppDelegate(),
                        ),
                      )),
            ),
          );
        });
  }

  // build discuz app theme
  DiscuzTheme _buildTheme(AppModel model) {
    if (model.appConf['darkTheme'] == true) {
      return DiscuzTheme(
          primaryColor: Color(model.appConf['themeColor']),
          textColor: Global.textColorDark,
          greyTextColor: Global.greyTextColorDark,
          scaffoldBackgroundColor: Global.scaffoldBackgroundColorDark,
          backgroundColor: Global.backgroundColorDark,
          brightness: Brightness.dark);
    }

    return DiscuzTheme(
      primaryColor: Color(model.appConf['themeColor']),
    );
  }
}

///
/// 这里相当于一个Tabbar，托管了一些顶级页面的views
/// 并包含bottom navigator，全局的drawer等
///
///
class _DiscuzAppDelegate extends StatefulWidget {
  const _DiscuzAppDelegate({Key key}) : super(key: key);
  @override
  __DiscuzAppDelegateState createState() => __DiscuzAppDelegateState();
}

class __DiscuzAppDelegateState extends State<_DiscuzAppDelegate> {
  /// 页面集合
  static const List<Widget> _views = [
    const ForumDelegate(),
    const SearchThreadDelegate(),
    const AccountDelegate()
  ];

  /// 底部按钮菜单
  final List<NavigatorItem> _items = [
    const NavigatorItem(icon: SFSymbols.layers_alt_fill),
    const NavigatorItem(icon: SFSymbols.search, shouldLogin: true),
    const NavigatorItem(icon: SFSymbols.person_alt, shouldLogin: true)
  ];

  /// 使用global key
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  /// states
  int _selected = 0;

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
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: _views.elementAt(_selected),
      bottomNavigationBar: DiscuzBottomNavigator(
        items: _items,
        onItemSelected: (index) => setState(() {
          _selected = index;
        }),
      ),
    );
  }
}
