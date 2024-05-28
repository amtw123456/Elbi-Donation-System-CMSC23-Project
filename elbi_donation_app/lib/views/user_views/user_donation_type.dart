import 'package:flutter/material.dart';
import 'donation_icons_icons.dart';

class DonationContainer extends StatefulWidget {
  final IconData iconData;
  final String label;
  final Function(bool) onPressed;

  const DonationContainer(
      {required this.iconData,
      required this.label,
      required this.onPressed,
      super.key});

  @override
  _DonationContainerState createState() => _DonationContainerState();
}

class _DonationContainerState extends State<DonationContainer> {
  Color _iconColor = const Color(0XFFD2D2D2);
  Color _backgroundColor = Colors.white;
  Color _textColor = const Color(0XFFD2D2D2);
  Color _borderColor = const Color(0XFFD2D2D2);

  void _changeColor() {
    setState(() {
      _borderColor = _borderColor == const Color(0XFFD2D2D2)
          ? const Color(0xFF37A980)
          : const Color(0XFFD2D2D2);
      _backgroundColor = _backgroundColor == Colors.white
          ? const Color(0xFF37A980)
          : Colors.white;
      _iconColor = _iconColor == const Color(0XFFD2D2D2)
          ? Colors.white
          : const Color(0XFFD2D2D2);
      _textColor = _textColor == const Color(0XFFD2D2D2)
          ? Colors.white
          : const Color(0XFFD2D2D2);
    });
    widget.onPressed(true);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _changeColor,
      child: Container(
        width: 150,
        height: 150,
        decoration: BoxDecoration(
          color: _backgroundColor,
          border: Border.all(
            color: _borderColor,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: widget.label == 'Clothes'
                  ? const EdgeInsets.only(right: 26.0)
                  : widget.label == 'Cash'
                      ? const EdgeInsets.only(right: 19.0)
                      : widget.label == 'Furniture'
                          ? const EdgeInsets.only(right: 18)
                          : EdgeInsets.zero,
              child: Icon(widget.iconData, size: 75, color: _iconColor),
            ),
            Text(widget.label,
                style: TextStyle(fontFamily: 'Poppins', color: _textColor)),
          ],
        ),
      ),
    );
  }
}
