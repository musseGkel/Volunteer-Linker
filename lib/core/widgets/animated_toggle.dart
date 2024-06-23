import 'package:flutter/material.dart';

class AnimatedToggle extends StatefulWidget {
  final List<String> values;
  final ValueChanged<int> onToggleCallback;
  final Color backgroundColor;
  final Color buttonColor;
  final Color textColor;

  const AnimatedToggle({
    super.key,
    required this.values,
    required this.onToggleCallback,
    this.backgroundColor = const Color(0xFFe7e7e8),
    this.buttonColor = const Color(0xFFFFFFFF),
    this.textColor = const Color(0xFF000000),
  });

  @override
  _AnimatedToggleState createState() => _AnimatedToggleState();
}

class _AnimatedToggleState extends State<AnimatedToggle> {
  final ValueNotifier<bool> initialPosition = ValueNotifier<bool>(true);

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return Container(
      width: width * 0.6,
      height: width * 0.13,
      margin: const EdgeInsets.all(20),
      child: Stack(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              initialPosition.value = !initialPosition.value;
              var index = initialPosition.value ? 0 : 1;
              widget.onToggleCallback(index);
            },
            child: Container(
              width: width * 0.6,
              height: width * 0.13,
              decoration: ShapeDecoration(
                color: widget.backgroundColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(width * 0.1),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                  widget.values.length,
                  (index) => Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                    child: Text(
                      widget.values[index],
                      style: TextStyle(
                        fontSize: width * 0.045,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xAA000000),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          ValueListenableBuilder<bool>(
            valueListenable: initialPosition,
            builder: (context, value, child) {
              return AnimatedAlign(
                duration: const Duration(milliseconds: 250),
                curve: Curves.decelerate,
                alignment: value ? Alignment.centerLeft : Alignment.centerRight,
                child: Container(
                  width: width * 0.33,
                  height: width * 0.13,
                  decoration: ShapeDecoration(
                    color: widget.buttonColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(width * 0.1),
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    value ? widget.values[0] : widget.values[1],
                    style: TextStyle(
                      fontSize: width * 0.045,
                      color: widget.textColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
