import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../Ultilities/App_Colors.dart';

class CatagoryChip extends StatefulWidget {
  String CatagoryTitle;

  CatagoryChip({super.key, required this.CatagoryTitle});

  @override
  State<CatagoryChip> createState() => _CatagoryChipState();
}

class _CatagoryChipState extends State<CatagoryChip> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(10),
          ),
          padding: EdgeInsetsGeometry.all(10),
          child: Column(
            children: [
              widget.CatagoryTitle.toLowerCase() == "food"
                  ? FaIcon(FontAwesomeIcons.burger, color: Colors.white)
                  : widget.CatagoryTitle.toLowerCase() == "shopping"
                  ? FaIcon(FontAwesomeIcons.bagShopping, color: Colors.white)
                  : widget.CatagoryTitle.toLowerCase() == "travel"
                  ? FaIcon(FontAwesomeIcons.plane, color: Colors.white)
                  : widget.CatagoryTitle.toLowerCase() == "Entertainment"
                  ? FaIcon(FontAwesomeIcons.ticket, color: Colors.white)
                  : FaIcon(FontAwesomeIcons.mobileRetro, color: Colors.white),
              SizedBox(height: 8),
              Text(
                widget.CatagoryTitle[0].toUpperCase() + widget.CatagoryTitle.substring(1),
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
