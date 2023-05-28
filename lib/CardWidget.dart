import 'package:flutter/material.dart';
class CardWidget extends StatefulWidget {
  final Function (GlobalKey key) builder;

  const CardWidget({
     required this.builder,
  }) ;

  @override
  State<CardWidget> createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
  final gl =GlobalKey();
  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      key: gl,
      child: widget.builder(gl),
    );
  }
}
