import 'package:flutter/material.dart';
import 'donation_icons_icons.dart';

class DonationContainer extends StatefulWidget {
  final IconData iconData;
  final String label;
  final Function(bool, String) onPressed;
  final bool initiallySelected;
  final Function(bool, String) onRemoved;

  const DonationContainer({
    required this.iconData,
    required this.label,
    required this.onPressed,
    this.initiallySelected = false,
    required this.onRemoved,
    Key? key,
  }) : super(key: key);

  @override
  _DonationContainerState createState() => _DonationContainerState();
}

class _DonationContainerState extends State<DonationContainer> {
  late bool _isSelected;
  Color _iconColor = const Color(0XFFD2D2D2); 
  Color _backgroundColor = Colors.white;
  Color _textColor = const Color(0XFFD2D2D2);
  Color _borderColor = const Color(0XFFD2D2D2);

  @override
  void initState() {
    super.initState();
    _isSelected = widget.initiallySelected;
    if (_isSelected) {
      _iconColor = Colors.white;
      _backgroundColor = const Color(0xFF37A980);
      _textColor = Colors.white;
      _borderColor = const Color(0xFF37A980);
    }
  }

  void _changeColor() {
    setState(() {
      _isSelected = !_isSelected;
      _borderColor = _isSelected ? const Color(0xFF37A980) : const Color(0XFFD2D2D2);
      _backgroundColor = _isSelected ? const Color(0xFF37A980) : Colors.white;
      _iconColor = _isSelected ? Colors.white : const Color(0XFFD2D2D2);
      _textColor = _isSelected ? Colors.white : const Color(0XFFD2D2D2);
    });
    if (_isSelected) {
      widget.onPressed(_isSelected, widget.label);
    } else {
      widget.onRemoved(_isSelected, widget.label); // Call the onRemoved callback
    }
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
            Text(widget.label, style: TextStyle(fontFamily: 'Poppins', color: _textColor)),
          ],
        ),
      ),
    );
  }
}