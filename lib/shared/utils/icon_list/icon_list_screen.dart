import 'package:flutter/material.dart';
import 'package:pos_app/core.dart';

class IconListScreen extends StatefulWidget {
  @override
  _IconListScreenState createState() => _IconListScreenState();
}

class _IconListScreenState extends State<IconListScreen> {
  List<Map<String, IconData>> iconList = [
    {
      "fa_user_clock": FontAwesomeIcons.userClock,
    },
    {
      "pregnant_woman": Icons.pregnant_woman,
    },
    {
      "fa_user_friends": FontAwesomeIcons.userFriends,
    },
    {
      "comment_dollar": FontAwesomeIcons.commentDollar,
    }
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: 4,
        itemBuilder: (context, index) {
          return Container();
        },
      ),
    );
  }
}
