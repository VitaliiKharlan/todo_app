import 'package:flutter/material.dart';

class InProgressIndicator extends StatefulWidget {
  final double progress;
  const InProgressIndicator({super.key, required this.progress});

  @override
  _InProgressIndicatorState createState() => _InProgressIndicatorState();
}

class _InProgressIndicatorState extends State<InProgressIndicator> {
  @override
  Widget build(BuildContext context) {
    final valuePercent = widget.progress / 100;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: 4,
            ),
            child: SizedBox(
              width: double.infinity,
              height: 8,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: valuePercent,
                  backgroundColor: Colors.lightBlueAccent[300],
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.purple),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
