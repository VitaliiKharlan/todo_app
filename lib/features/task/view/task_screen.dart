import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/features/add_new_task/bloc/add_new_task_bloc.dart';
import 'package:todo_app/theme/app_text_style.dart';

final addNewTaskBloc = AddNewTaskBloc();

@RoutePage()
class TaskScreen extends StatelessWidget {
  const TaskScreen({
    super.key,
    required this.theme,
  });

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddNewTaskBloc(),
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            pinned: true,
            snap: true,
            floating: true,
            title: Center(
              child: Text(
                'TODO',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            elevation: 0,
            surfaceTintColor: Colors.transparent,
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(80),
              child: AddNewTaskButton(theme: theme),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 24)),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 100,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: 8,
                separatorBuilder: (context, index) => SizedBox(width: 20),
                padding: EdgeInsets.only(left: 20),
                itemBuilder: (context, index) => BaseContainer(
                  width: 192,
                  padding: EdgeInsets.all(16),
                  margin: EdgeInsets.zero,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Monday',
                        style: theme.textTheme.bodyLarge?.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.green),
                      ),
                      SizedBox(height: 10),
                      Text('27/01/2025'),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 24)),
          SliverList.builder(
            itemCount: 5,
            itemBuilder: (context, index) => TaskListCard(),
          ),
          //
          // BlocBuilder<AddNewTaskBloc, AddNewTaskState>(
          //   builder: (context, state) {
          //     if (state is AddNewTaskLoadedState) {
          //       return SliverList.builder(
          //         itemCount: state.tasks.length,
          //         itemBuilder: (context, index) => TaskListCard(),
          //       );
          //     }
          //     if (state is AddNewTaskLoadingFailureState) {
          //       return Center(
          //         child: Text(
          //           state.exception?.toString() ?? 'MAGA',
          //           style: AppTextStyle.defaultSemiBoldLargeTitle,
          //         ),
          //       );
          //     }
          //     return Center(
          //       child: CircularProgressIndicator(),
          //     );
          //   },
          // ),
          //
        ],
      ),
    );
  }
}

class BaseContainer extends StatelessWidget {
  const BaseContainer({
    super.key,
    required this.width,
    this.margin,
    required this.child,
    this.padding = const EdgeInsets.only(left: 12),
  });

  final double width;
  final EdgeInsets? margin;
  final EdgeInsets padding;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: width,
      margin: margin,
      padding: padding,
      // padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: theme.hintColor.withAlpha(10),
        borderRadius: BorderRadius.circular(20),
      ),
      child: child,
    );
  }
}

class TaskListCard extends StatelessWidget {
  const TaskListCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<AddNewTaskBloc, AddNewTaskState>(
        builder: (context, state) {
      if (state is AddNewTaskLoadedState) {
        return BaseContainer(
          width: double.infinity,
          margin: EdgeInsets.symmetric(horizontal: 20).copyWith(bottom: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                Icons.home,
                color: Colors.deepPurple,
              ),
              Text(state.tasks.toString(),
                  style: theme.textTheme.bodyLarge),
              Column(
                children: [
                  Text(
                    '29 Jan',
                    style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800),
                  ),
                  SizedBox(height: 4),
                  Text(
                    '23:24',
                    style: TextStyle(fontSize: 8),
                  ),
                ],
              ),
            ],
          ),
        );
      }
      return Center(
        child: CircularProgressIndicator(),
      );
    });
  }
}

class AddNewTaskButton extends StatelessWidget {
  const AddNewTaskButton({
    super.key,
    required this.theme,
  });

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BaseContainer(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 20).copyWith(bottom: 8),
      child: Row(
        children: [
          Icon(Icons.add),
          SizedBox(height: 12),
          Text(
            'Add new task',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: theme.hintColor.withAlpha(40),
            ),
          ),
        ],
      ),
    );
  }
}
