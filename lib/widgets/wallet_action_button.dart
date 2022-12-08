import 'package:flutter/material.dart';

class SimpleConstrainedButton extends StatefulWidget {
  SimpleConstrainedButton({
    Key? key,
    required this.onPressed,
    required this.child,
    this.borderRadius,
    this.textStyle,
    this.primary,
    this.elevation,
    required this.constraints
  }) : super(key: key);

  Widget child;
  void Function() onPressed;
  BorderRadius? borderRadius;
  TextStyle? textStyle;
  Color? primary;
  double? elevation;
  BoxConstraints constraints;


  @override
  State<SimpleConstrainedButton> createState() => 
      _SimpleConstrainedButtonState();
}

class _SimpleConstrainedButtonState extends State<SimpleConstrainedButton> {
  @override
  Widget build(BuildContext context) {
    var t = Theme.of(context);
    widget.primary ??= t.colorScheme.primary;
    return Theme(
      data: ThemeData(
        textTheme: TextTheme(
          button: TextStyle(
            color: t.colorScheme.onPrimary,
          )
        )
      ),
      child: ConstrainedBox(
        constraints: widget.constraints,
        child: Material(
          color: widget.primary,
          borderRadius: widget.borderRadius,
          elevation: widget.elevation ?? 2,
          child: InkWell(
            borderRadius: widget.borderRadius,
            hoverColor: widget.primary?.withOpacity(0.8),
            onTap: widget.onPressed,
            child: widget.child
          )
        ),
      )
    );
  }
}