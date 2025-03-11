import 'dart:ui' as ui;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import 'package:todo_app/features/create_new_task/bloc/entities/task_entity.dart';
import 'package:todo_app/features/create_new_task/data/models/location_details.dart';
import 'package:todo_app/features/create_new_task/data/repositories/geo_position_search_for_weather_repository.dart';
import 'package:todo_app/features/create_new_task/data/repositories/place_details_repository.dart';
import 'package:todo_app/features/location_search/bloc/location_search_bloc.dart';
import 'package:todo_app/features/task_details/task_details.dart';
import 'package:todo_app/ui/theme/app_colors.dart';
import 'package:todo_app/ui/theme/app_text_style.dart';

@RoutePage()
class TaskDetailsScreen extends StatefulWidget {
  const TaskDetailsScreen({
    super.key,
    required this.task,
    // required this.localizedName,
    required this.onDelete,
  });

  final Task task;

  // final String localizedName;

  final void Function(Task) onDelete;

  @override
  State<TaskDetailsScreen> createState() => _TaskDetailsScreenState();
}

class _TaskDetailsScreenState extends State<TaskDetailsScreen> {
  bool _isExpanded = false;

  String _getTrimmedText(String text, TextStyle style, double maxWidth) {
    final textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      maxLines: 3,
      textDirection: ui.TextDirection.ltr,
    )..layout(maxWidth: maxWidth);

    if (!textPainter.didExceedMaxLines) return text;

    String trimmedText = text;
    while (textPainter.didExceedMaxLines) {
      trimmedText = trimmedText.substring(0, trimmedText.length - 1);
      textPainter.text = TextSpan(text: trimmedText, style: style);
      textPainter.layout(maxWidth: maxWidth);
    }

    return trimmedText;
  }

  final placeDetailsRepository = PlaceDetailsRepository();
  final geoPositionSearchForWeatherRepository =
      GeoPositionSearchForWeatherRepository();

  late LocationDetailsModel locationDetailsModel;



  @override
  void initState() {
    super.initState();


    locationDetailsModel = LocationDetailsModel(
      description: 'Sample Location',
      lat: 37.7749,
      lng: -122.4194,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      debugPrint('Adding LocationSelectEvent');
      BlocProvider.of<LocationSearchBloc>(context).add(
        LocationSelectEvent(locationDetailsModel),
      );
    });
  }


  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocProvider(
      create: (context) {
        final locationSearchBloc = LocationSearchBloc(
          placeDetailsRepository,
          geoPositionSearchForWeatherRepository,
        );


        locationSearchBloc.add(LocationSelectEvent(locationDetailsModel));

        return locationSearchBloc;
      },
      // create: (context) => LocationSearchBloc(
      //   placeDetailsRepository,
      //   geoPositionSearchForWeatherRepository,
      // ),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(width: 12),
              SizedBox(
                width: 40,
                height: 40,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    color: Colors.grey.withAlpha(20),
                    child: Center(
                      child: IconButton(
                        icon: Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          AutoRouter.of(context).maybePop();
                        },
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 32),
                    child: Text(
                      'Task Details',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
                onPressed: () {
                  widget.onDelete(widget.task);
                },
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 20,
              top: 20,
              right: 20,
            ),
            child: Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.task.taskTitle,
                      style: AppTextStyle.appBar.copyWith(
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                          color: Colors.black),
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        SizedBox(width: 8),
                        if (widget.task.taskType != null)
                          ClipOval(
                            child: Container(
                              color: Colors.lightBlueAccent.withAlpha(40),
                              padding: EdgeInsets.all(12),
                              child: SvgPicture.asset(
                                'assets/svg/${widget.task.taskType!.name}.svg',
                                width: 24,
                                height: 24,
                                colorFilter: ColorFilter.mode(
                                  widget.task.taskType!.color,
                                  BlendMode.srcIn,
                                ),
                              ),
                            ),
                          ),
                        SizedBox(width: 24),
                        if (widget.task.taskDeadline != null) ...[
                          SizedBox(height: 12),
                          Text(
                            DateFormat("dd MMMM, 'at' hh:mm a")
                                .format(widget.task.taskDeadline!),
                            style: AppTextStyle.dateProgressIndicator.copyWith(
                                color: AppColors.dateProgressIndicator),
                          ),
                        ]
                      ],
                    ),
                    SizedBox(height: 32),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'In Progress',
                          style: theme.textTheme.bodySmall?.copyWith(
                            fontSize: 15,
                            fontWeight: FontWeight.w800,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          '${widget.task.progress}%',
                          style: theme.textTheme.bodySmall?.copyWith(
                            fontSize: 15,
                            fontWeight: FontWeight.w800,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    // InProgressIndicator(),
                    InProgressIndicator(
                      progress: widget.task.progress,
                    ),
                    SizedBox(height: 32),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Project Milestone',
                          style: theme.textTheme.bodySmall?.copyWith(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                        if (widget.task.taskRemindTime != null &&
                            widget.task.taskRemindTime!.isNotEmpty) ...[
                          SizedBox(height: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: widget.task.taskRemindTime!
                                .map((milestone) => Padding(
                                      padding: const EdgeInsets.only(bottom: 8),
                                      child: Text(
                                        DateFormat("dd MMMM, 'at' hh:mm a")
                                            .format(milestone),
                                        style: AppTextStyle
                                            .dateProgressIndicator
                                            .copyWith(
                                          fontSize: 12,
                                          color:
                                              AppColors.dateProgressIndicator,
                                        ),
                                      ),
                                    ))
                                .toList(),
                          ),
                        ],
                        if (widget.task.taskRemindTime != null &&
                            widget.task.taskRemindTime!.isEmpty) ...[
                          SizedBox(height: 12),
                          Text(
                            DateFormat("dd MMMM, 'at' hh:mm a")
                                .format(widget.task.taskRemindTime!.first),
                            style: AppTextStyle.dateProgressIndicator.copyWith(
                              fontSize: 12,
                              color: AppColors.dateProgressIndicator,
                            ),
                          ),
                        ],
                      ],
                    ),

                    SizedBox(height: 20),
                    Text(
                      'Overview',
                      style: theme.textTheme.bodySmall?.copyWith(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 8),
                    if (widget.task.taskDescription != null)
                      LayoutBuilder(
                        builder: (context, constraints) {
                          final textStyle = AppTextStyle.description.copyWith(
                            color: AppColors.dateProgressIndicator,
                            height: 1.5,
                          );

                          final fullText = widget.task.taskDescription ?? '';
                          final textPainter = TextPainter(
                            text: TextSpan(text: fullText, style: textStyle),
                            maxLines: 3,
                            textDirection: ui.TextDirection.ltr,
                          )..layout(
                              maxWidth: constraints.maxWidth,
                            );

                          final bool isOverflowing =
                              textPainter.didExceedMaxLines;

                          String trimmedText = fullText;

                          if (isOverflowing) {
                            trimmedText = _getTrimmedText(
                                fullText, textStyle, constraints.maxWidth);
                            trimmedText = '${trimmedText.trimRight()} ...';
                          }

                          return RichText(
                            textAlign: TextAlign.justify,
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: _isExpanded ? fullText : trimmedText,
                                  style: textStyle,
                                ),
                                if (isOverflowing)
                                  TextSpan(
                                    text: _isExpanded
                                        ? ' Read Less'
                                        : ' Read More',
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
                      ),
                    SizedBox(height: 20),
                    BlocBuilder<LocationSearchBloc, LocationSearchState>(
                      builder: (context, state) {
                        if (state is LocationSearchLoadingState) {
                          debugPrint('TaskDetailsScreen: LocationSearchLoadingState');
                          return Center(child: CircularProgressIndicator());
                        } else if (state is LocationSearchFailureState) {
                          return Text(
                            'Error: ${state.exception}',
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        } else if (state is LocationSelectedState) {
                          debugPrint('TaskDetailsScreen: ${state.localizedName}');
                          return Text(

                            'Location: ${state.localizedName}',
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        } else {
                          return SizedBox.shrink();
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TaskDetailsScreenWrapper extends StatelessWidget {
  final Task task;
  final void Function(Task) onDelete;
  final PlaceDetailsRepository placeDetailsRepository;
  final GeoPositionSearchForWeatherRepository geoPositionSearchForWeatherRepository;

  TaskDetailsScreenWrapper({
    required this.task,
    required this.onDelete,
    required this.placeDetailsRepository,
    required this.geoPositionSearchForWeatherRepository,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LocationSearchBloc>(
      create: (context) => LocationSearchBloc(
        placeDetailsRepository,
        geoPositionSearchForWeatherRepository,
      ),
      child: TaskDetailsScreen(
        task: task,
        onDelete: onDelete,
      ),
    );
  }
}
