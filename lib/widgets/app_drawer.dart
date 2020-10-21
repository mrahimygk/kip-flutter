import 'package:flutter/material.dart';
import 'package:kip/util/custom_splash_factory.dart';
import 'package:kip/widgets/custom_row_widget.dart';

import 'custom_text_widget.dart';

class AppDrawer extends StatelessWidget {
  final Function(int) callback;

  const AppDrawer({
    Key key,
    @required this.callback,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _heigth = MediaQuery.of(context).size.height;
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: _heigth * 0.02, vertical: _heigth * 0.03),
            child: CustomTextWidget(
              text: 'Keep',
              size: _heigth * 0.04,
            ),
          ),
          _customInkwellContainer(
            icon: Icons.lightbulb_outline,
            label: 'Notes',
            onTap: () {
              Navigator.pop(context);
              //Notes page is on 0th index
              callback(0);
            },
          ),
          _customInkwellContainer(
            icon: Icons.notifications_none,
            label: 'Reminders',
            onTap: () {
              Navigator.pop(context);
              //Notes page is on 1st index
              callback(1);
            },
          ),
          Divider(
            thickness: 1,
          ),
          _customInkwellContainer(
            icon: Icons.archive_rounded,
            label: 'Archived',
            onTap: () {
              Navigator.pop(context);
              //Notes page is on 2nd index
              callback(2);
            },
          ),
          _customInkwellContainer(
            icon: Icons.delete_outline,
            label: 'Deleted',
            onTap: () {
              Navigator.pop(context);
              //Notes page is on 3rd index
              callback(3);
            },
          ),
          Divider(
            thickness: 1,
          ),
          _customInkwellContainer(
            icon: Icons.settings,
            label: 'Settings',
            onTap: () => Navigator.popAndPushNamed(context, '/settings'),
          ),
          _customInkwellContainer(
            icon: Icons.help_outline,
            label: 'Help & feedback',
            onTap: () => Navigator.popAndPushNamed(context, '/support'),
          ),
        ],
      ),
    );
  }

  Widget _customInkwellContainer({
    String label,
    IconData icon,
    void Function() onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: InkWell(
        splashFactory: CustomSplashFactory(),
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(35.0),
          topRight: Radius.circular(35.0),
        ),
        highlightColor: Colors.transparent,
        child: Container(
          child: CustomRowWithIcon(
            icon: icon,
            label: label,
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}
