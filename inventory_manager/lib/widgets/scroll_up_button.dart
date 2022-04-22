import 'package:flutter/material.dart';

class ScrollUpButton extends StatefulWidget {
  const ScrollUpButton(this.controller, {Key? key}) : super(key: key);

  final ScrollController controller;

  @override
  _ScrollUpButtonState createState() => _ScrollUpButtonState();
}

class _ScrollUpButtonState extends State<ScrollUpButton> {
  bool _showScrollUp = false;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(() {
      if (widget.controller.position.pixels > 20 && !_showScrollUp) {
        setState(() {
          _showScrollUp = true;
        });
      } else if (widget.controller.position.pixels < 20 && _showScrollUp) {
        setState(() {
          _showScrollUp = false;
        });
      }
      // On GitHub there was a question on how to determine the event
      // of widget being scrolled to the bottom. Here's the sample
      // if (widget.controller.position.hasViewportDimension &&
      //     widget.controller.position.pixels >=
      //         widget.controller.position.maxScrollExtent - 0.01) {
      //   print('Scrolled to bottom');
      //}
    });
  }

  @override
  Widget build(BuildContext context) {
    return _showScrollUp
        ? Positioned(
            right: 10,
            bottom: 45,
            child: OutlinedButton(
              child: const Text('↑↑ go up ↑↑'),
              onPressed: () => widget.controller.animateTo(0,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeIn),
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.grey[800]),
                  foregroundColor: MaterialStateProperty.all(Colors.white)),
            ))
        : const SizedBox();
  }
}
