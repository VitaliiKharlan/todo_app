import 'package:flutter/material.dart';

import 'dart:ui' as ui;
import 'package:flutter/gestures.dart';

import 'package:todo_app/features/create_new_task/bloc/entities/task_entity.dart';

class OverviewWidget extends StatefulWidget {
  const OverviewWidget({
    super.key,
    required this.task,
  });

  final Task task;

  @override
  State<OverviewWidget> createState() => _OverviewWidgetState();
}

class _OverviewWidgetState extends State<OverviewWidget> {
  bool _isExpanded = false;
  static const int _maxLines = 3;

  String _getTrimmedText({
    required String text,
    required TextStyle style,
    required double maxWidth,
    required int maxLines,
  }) {
    final textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      maxLines: maxLines,
      textDirection: ui.TextDirection.ltr,
    )..layout(maxWidth: maxWidth);

    if (!textPainter.didExceedMaxLines) return text;

    String trimmedText = text;
    while (textPainter.didExceedMaxLines && trimmedText.isNotEmpty) {
      trimmedText = trimmedText.substring(0, trimmedText.length - 1);
      textPainter.text = TextSpan(text: trimmedText, style: style);
      textPainter.layout(maxWidth: maxWidth);
    }

    return trimmedText.trimRight();
  }




  // String _getTrimmedText(String text, TextStyle style, double maxWidth) {
  //   final textPainter = TextPainter(
  //     text: TextSpan(text: text, style: style),
  //     maxLines: 3,
  //     textDirection: ui.TextDirection.ltr,
  //   )..layout(maxWidth: maxWidth);
  //
  //   if (!textPainter.didExceedMaxLines) return text;
  //
  //   String trimmedText = text;
  //   while (textPainter.didExceedMaxLines) {
  //     trimmedText = trimmedText.substring(0, trimmedText.length - 1);
  //     textPainter.text = TextSpan(text: trimmedText, style: style);
  //     textPainter.layout(maxWidth: maxWidth);
  //   }
  //
  //   return trimmedText;
  // }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final description = widget.task.taskDescription?.trim();
    if (description == null || description.isEmpty) return const SizedBox();

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 12,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Overview',
              style: theme.textTheme.titleLarge,
            ),
            SizedBox(height: 8),
            if (widget.task.taskDescription != null)
              LayoutBuilder(
                builder: (context, constraints) {
                  final textStyle =
                      theme.textTheme.bodySmall ?? const TextStyle();
                  final fullText = description;

                  final textPainter = TextPainter(
                    text: TextSpan(text: fullText, style: textStyle),
                    maxLines: _maxLines,
                    textDirection: ui.TextDirection.ltr,
                  )..layout(maxWidth: constraints.maxWidth);

                  final bool isOverflowing = textPainter.didExceedMaxLines;

                  String displayText = fullText;
                  if (!_isExpanded && isOverflowing) {
                    displayText = _getTrimmedText(
                      text: fullText,
                      style: textStyle,
                      maxWidth: constraints.maxWidth,
                      maxLines: _maxLines,
                    );
                    displayText += ' ...';
                  }

                  // final textPainter = TextPainter(
                  //   text: TextSpan(text: fullText, style: textStyle),
                  //   maxLines: 3,
                  //   textDirection: ui.TextDirection.ltr,
                  // )..layout(
                  //     maxWidth: constraints.maxWidth,
                  //   );
                  //
                  // final bool isOverflowing = textPainter.didExceedMaxLines;
                  //
                  // String trimmedText = fullText;
                  //
                  // if (isOverflowing) {
                  //   trimmedText = _getTrimmedText(
                  //       fullText, textStyle, constraints.maxWidth);
                  //   trimmedText = '${trimmedText.trimRight()} ...';
                  // }

                  return RichText(
                    textAlign: TextAlign.justify,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: displayText,
                          style: textStyle,
                        ),
                        if (isOverflowing)
                          TextSpan(
                            text: _isExpanded ? ' Read Less' : ' Read More',
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                setState(() {
                                  _isExpanded = !_isExpanded;
                                });
                              },
                          ),
                      ],
                    ),
                  );
                },
              )
          ],
        ),
      ),
    );
  }
}
