import 'package:discuzq/views/users/usersHomeDelegate.dart';
import 'package:flutter/material.dart';

import 'package:discuzq/models/userModel.dart';
import 'package:discuzq/router/route.dart';
import 'package:discuzq/widgets/common/discuzLink.dart';

class UserLink extends StatelessWidget {
  final UserModel user;

  UserLink({@required this.user});

  @override
  Widget build(BuildContext context) {
    return DiscuzLink(
      label: user.username,
      padding: const EdgeInsets.only(right: 5),
      onTap: () => DiscuzRoute.open(
          context: context,
          widget: UserHomeDelegate(
            user: user,
          )),
    );
  }
}
