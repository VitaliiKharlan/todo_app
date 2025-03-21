import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/features/create_new_task/data/models/location_details.dart';
import 'package:todo_app/router/router.dart';
import 'package:todo_app/ui/theme/app_text_style.dart';

class TaskLocationFieldWidget extends StatefulWidget {
  const TaskLocationFieldWidget({
    super.key,
    required this.taskLocation,
    required this.onLocationPicked,
  });

  final LocationDetailsModel? taskLocation;
  final ValueChanged<LocationDetailsModel?> onLocationPicked;

  @override
  State<TaskLocationFieldWidget> createState() =>
      _TaskLocationFieldWidgetState();
}

class _TaskLocationFieldWidgetState extends State<TaskLocationFieldWidget> {
  _getLocationFromPreviousScreen() async {
    final result =
        await context.router.push<LocationDetailsModel>(LocationSearchRoute());
    if (result != null) {
      widget.onLocationPicked(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Location',
          style: AppTextStyle.appBar.copyWith(
              fontSize: 22, fontWeight: FontWeight.w800, color: Colors.black),
        ),
        SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          height: 40,
          child: ElevatedButton.icon(
            onPressed: () => {
              _getLocationFromPreviousScreen(),
            },
            icon: const Icon(Icons.location_city),
            label: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: 8),
                Text(
                  widget.taskLocation == null
                      ? 'Pick a place'
                      : widget.taskLocation?.description ?? '',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(Colors.white),
              foregroundColor: WidgetStateProperty.all(
                Colors.black.withAlpha(60),
              ),
              side: WidgetStateProperty.all(
                BorderSide(
                  color: Colors.grey.withAlpha(80),
                  width: 2,
                ),
              ),
              overlayColor: WidgetStateProperty.all<Color>(Colors.white),
              shadowColor: WidgetStateProperty.all<Color>(Colors.white),
              elevation: WidgetStateProperty.all<double>(0.1),
            ),
          ),
        ),
      ],
    );
  }
}
