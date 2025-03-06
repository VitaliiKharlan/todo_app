import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import 'package:todo_app/features/create_new_task/bloc/entities/task_entity.dart';
import 'package:todo_app/features/task_details/task_details.dart';
import 'package:todo_app/ui/theme/app_colors.dart';
import 'package:todo_app/ui/theme/app_text_style.dart';

@RoutePage()
class TaskDetailsScreen extends StatelessWidget {
  const TaskDetailsScreen({
    super.key,
    required this.task,
    required this.onDelete,
  });

  final Task task;

  final void Function(Task) onDelete;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
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
                onDelete(task);
              },
            ),
          ],
        ),
      ),
      body: Padding(
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
                  task.taskTitle,
                  style: AppTextStyle.appBar.copyWith(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      color: Colors.black),
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    SizedBox(width: 8),
                    if (task.taskType != null)
                      ClipOval(
                        child: Container(
                          color: Colors.lightBlueAccent.withAlpha(40),
                          padding: EdgeInsets.all(12),
                          child: SvgPicture.asset(
                            'assets/svg/${task.taskType!.name}.svg',
                            width: 24,
                            height: 24,
                            colorFilter: ColorFilter.mode(
                              task.taskType!.color,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                      ),
                    SizedBox(width: 24),
                    if (task.taskDeadline != null) ...[
                      SizedBox(height: 12),
                      Text(
                        DateFormat("dd MMMM, 'at' hh:mm a")
                            .format(task.taskDeadline!),
                        style: AppTextStyle.dateProgressIndicator
                            .copyWith(color: AppColors.dateProgressIndicator),
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
                      // '60%',
                      '${task.progress}%',
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
                  progress: task.progress,
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
                    if (task.taskRemindTime != null &&
                        task.taskRemindTime!.isNotEmpty) ...[
                      SizedBox(height: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: task.taskRemindTime!
                            .map((milestone) => Padding(
                                  padding: const EdgeInsets.only(bottom: 8),
                                  child: Text(
                                    DateFormat("dd MMMM, 'at' hh:mm a")
                                        .format(milestone),
                                    style: AppTextStyle.dateProgressIndicator
                                        .copyWith(
                                      fontSize: 12,
                                      color: AppColors.dateProgressIndicator,
                                    ),
                                  ),
                                ))
                            .toList(),
                      ),
                    ],
                    if (task.taskRemindTime != null &&
                        task.taskRemindTime!.isEmpty) ...[
                      SizedBox(height: 12),
                      Text(
                        DateFormat("dd MMMM, 'at' hh:mm a")
                            .format(task.taskRemindTime!.first),
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
                if (task.taskDescription != null)
                  SizedBox(
                    width: double.infinity,
                    height: 100,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          task.taskDescription.toString(),
                          style: AppTextStyle.description
                              .copyWith(color: AppColors.dateProgressIndicator),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                        ),
                        if (task.taskDescription.toString().length > 3)
                          TextButton(
                            onPressed: () {},
                            child: Text(
                              "...Read More",
                              style: TextStyle(color: Colors.blue),
                            ),
                          ),
                      ],
                    ),
                  ),
                SizedBox(height: 20),
                //     Text(
                //       'Members',
                //       style: theme.textTheme.bodySmall?.copyWith(
                //         fontSize: 24,
                //         fontWeight: FontWeight.w500,
                //         color: Colors.black,
                //       ),
                //     ),
                //     SizedBox(height: 56),
                //     Text(
                //       'Tasks',
                //       style: theme.textTheme.bodySmall?.copyWith(
                //         fontSize: 24,
                //         fontWeight: FontWeight.w500,
                //         color: Colors.black,
                //       ),
                //     ),
                //     SizedBox(height: 20),
                //     Expanded(
                //       child: CustomScrollView(
                //         slivers: [
                //           SliverList(
                //             delegate: SliverChildBuilderDelegate(
                //               (context, index) {
                //                 return Container(
                //                   margin: const EdgeInsets.symmetric(
                //                     vertical: 12,
                //                     horizontal: 16,
                //                   ),
                //                   padding: const EdgeInsets.all(16),
                //                   decoration: BoxDecoration(
                //                     color: Colors.blueAccent,
                //                     borderRadius: BorderRadius.circular(12),
                //                   ),
                //                   child: Text(
                //                     'Item ${index + 1}',
                //                     style: const TextStyle(
                //                       color: Colors.white,
                //                       fontSize: 18,
                //                     ),
                //                   ),
                //                 );
                //               },
                //               childCount: 4,
                //             ),
                //           ),
                //         ],
                //       ),
                //     ),
                //   ],
                // ),
                // Positioned(
                //   bottom: 0,
                //   left: 0,
                //   right: 0,
                //   child: Container(
                //     height: 96,
                //     decoration: BoxDecoration(
                //       gradient: LinearGradient(
                //         begin: Alignment.topCenter,
                //         end: Alignment.bottomCenter,
                //         colors: [
                //           Colors.white.withAlpha(80),
                //           Colors.white.withAlpha(20),
                //           Colors.white,
                //         ],
                //       ),
                //     ),
                //     child: ImageFiltered(
                //       imageFilter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                //     ),
                //   ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
