import 'package:flutter/material.dart';

class SettingsHeadingsCard extends StatefulWidget {
  String HeadingTitle;

  SettingsHeadingsCard({super.key, required this.HeadingTitle});

  @override
  State<SettingsHeadingsCard> createState() => _SettingsHeadingsCardState();
}

class _SettingsHeadingsCardState extends State<SettingsHeadingsCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsGeometry.all(5.0),
      width: double.infinity,
      decoration: BoxDecoration(color: Colors.grey.shade400),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.HeadingTitle,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
