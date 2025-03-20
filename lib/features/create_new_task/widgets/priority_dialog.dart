import 'package:flutter/material.dart';

class PriorityDialog extends StatefulWidget {
  final int currentPriority;

  const PriorityDialog({
    super.key,
    required this.currentPriority,
  });

  @override
  _PriorityDialogState createState() => _PriorityDialogState();
}

class _PriorityDialogState extends State<PriorityDialog> {
  late int selectedPriority;

  @override
  void initState() {
    super.initState();
    selectedPriority = widget.currentPriority;
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
            int priority = index + 1;
            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedPriority = priority;
                });
              },
              child: Container(
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
                  borderRadius: BorderRadius.circular(8.0),
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
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () => Navigator.of(context).pop(selectedPriority),
          child: const Text('Save'),
        ),
      ],
    );
  }
}
