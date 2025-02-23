import 'package:flutter/material.dart';

import 'package:todo_app/features/create_new_task/create_new_task.dart';

class ShowTheCity extends StatelessWidget {
  const ShowTheCity({
    super.key,
    required this.city,
  });

  final String city;

  @override
  Widget build(BuildContext context) {
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
                        Navigator.of(context).pop(
                          MaterialPageRoute(
                            builder: (context) => LocationSearchAutocompleteScreen(),
                          ),
                        );
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
                    'Show The City',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          right: 20,
          top: 20,
          left: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 80),
            Center(
              child: Text(
                'Selected City:',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),

              ),
            ),
            SizedBox(height: 40),

            Center(
              child: Text(
                city,
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple,
                ),

              ),
            ),

          ],
        ),
      ),
    );
  }
}
