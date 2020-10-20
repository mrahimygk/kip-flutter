import 'package:flutter/material.dart';
import 'package:kip/util/custom_splash_factory.dart';
import 'package:kip/widgets/custom_row_widget.dart';

import 'custom_text_widget.dart';

class AppDrawer extends StatelessWidget {
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
            onTap: () => Navigator.pushReplacementNamed(context, '/home'),
          ),
          _customInkwellContainer(
            icon: Icons.notifications_none,
            label: 'Reminders',
            onTap: () => Navigator.pushReplacementNamed(context, '/reminders'),
          ),
          Divider(
            thickness: 1,
          ),
          _customInkwellContainer(
            icon: Icons.archive_rounded,
            label: 'Archived',
            onTap: () => Navigator.pushReplacementNamed(context, '/archive'),
          ),
          _customInkwellContainer(
            icon: Icons.delete_outline,
            label: 'Deleted',
            onTap: () => Navigator.pushReplacementNamed(context, '/delete'),
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
