import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class PriorityDialogWidget extends StatefulWidget {
  final int? taskPriority;

  const PriorityDialogWidget({
    super.key,
    this.taskPriority,
  });

  @override
  _PriorityDialogWidgetState createState() => _PriorityDialogWidgetState();
}

class _PriorityDialogWidgetState extends State<PriorityDialogWidget> {
  late int selectedPriority;

  @override
  void initState() {
    super.initState();
    selectedPriority = widget.taskPriority ?? 1;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Column(
        children: const [
          Text('Task Priority'),
          Divider(),
        ],
      ),
      content: SizedBox(
        width: double.maxFinite,
        child: GridView.builder(
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
          ),
          itemCount: 10,
          itemBuilder: (context, index) {
            final priority = index + 1;
            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedPriority = priority;
                });
              },
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: selectedPriority == priority
                      ? Colors.blue
                      : Colors.transparent,
                  border: Border.all(
                    color: selectedPriority == priority
                        ? Colors.blue
                        : Colors.grey,
                    width: 2.0,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.flag_outlined,
                      color: selectedPriority == priority
                          ? Colors.white
                          : Colors.black,
                      size: 16,
                    ),
                    SizedBox(height: 4),
                    Text(
                      priority.toString(),
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: selectedPriority == priority
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => context.router.maybePop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () => context.router.maybePop(selectedPriority),
          child: const Text('Save'),
        ),
      ],
    );
  }
}
