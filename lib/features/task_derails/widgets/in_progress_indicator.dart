import 'package:flutter/material.dart';

class InProgressIndicator extends StatefulWidget {
  const InProgressIndicator({super.key});

  @override
  _InProgressIndicatorState createState() => _InProgressIndicatorState();
}

final double _value = 60;
final double _valuePercent = _value/100;

class _InProgressIndicatorState extends State<InProgressIndicator> {

  @override
  Widget build(BuildContext context) {
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
                  value: _valuePercent,
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
