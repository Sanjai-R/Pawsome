import 'package:flutter/material.dart';

enum ButtonStyleType {
  elevated,
  filled,
  icon,
  text,
}

class ReusableButton extends StatefulWidget {
  final String text;
  final IconData icon;
  final ButtonStyleType style;
  final Function onPressed;

  ReusableButton({
    required this.text,
    this.icon = Icons.add,
    this.style = ButtonStyleType.elevated,
    required this.onPressed,
  });

  @override
  _ReusableButtonState createState() => _ReusableButtonState();
}

class _ReusableButtonState extends State<ReusableButton> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return _isLoading ? CircularProgressIndicator() : _buildButton();
  }

  Widget _buildButton() {
    switch (widget.style) {
      case ButtonStyleType.elevated:
        return ElevatedButton(
          child: _buildButtonContent(),
          onPressed: _handleOnPressed,
        );
      case ButtonStyleType.filled:
        return TextButton(
          style: TextButton.styleFrom(),
          child: _buildButtonContent(),
          onPressed: _handleOnPressed,
        );
      case ButtonStyleType.icon:
        return IconButton(
          icon: Icon(widget.icon),
          onPressed: _handleOnPressed,
        );
      case ButtonStyleType.text:
        return TextButton(
          child: _buildButtonContent(),
          onPressed: _handleOnPressed,
        );
      default:
        return SizedBox.shrink();
    }
  }

  Widget _buildButtonContent() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.icon != null) Icon(widget.icon),
        if (widget.icon != null && widget.text.isNotEmpty) SizedBox(width: 8),
        if (widget.text.isNotEmpty) Text(widget.text),
      ],
    );
  }

  void _handleOnPressed() async {
    setState(() {
      _isLoading = true;
    });

    await widget.onPressed();

    setState(() {
      _isLoading = false;
    });
  }
}
