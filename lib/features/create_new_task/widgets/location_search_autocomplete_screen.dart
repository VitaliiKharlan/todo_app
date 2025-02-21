import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/features/create_new_task/data/models/location_details.dart';

import 'package:todo_app/features/create_new_task/data/models/location_search_autocomplete.dart';
import 'package:todo_app/features/create_new_task/data/repositories/location_details_repository.dart';
import 'package:todo_app/features/create_new_task/data/repositories/location_search_autocomplete_repository.dart';

@RoutePage()
class LocationSearchAutocompleteScreen extends StatefulWidget {
  const LocationSearchAutocompleteScreen({
    super.key,
  });

  @override
  State<LocationSearchAutocompleteScreen> createState() =>
      _LocationSearchAutocompleteScreenState();
}

class _LocationSearchAutocompleteScreenState
    extends State<LocationSearchAutocompleteScreen> {
  final controllerLocationSearchAutocomplete = TextEditingController();
  final locationSearchAutocompleteRepository =
      LocationSearchAutocompleteRepository();
  List<LocationSearchAutocompleteModel> listOfLocation = [];

  final locationDetailsRepository = LocationDetailsRepository();
  List<LocationDetailsModel> locationDetails = [];

  @override
  void initState() {
    super.initState();
    controllerLocationSearchAutocomplete.addListener(() {
      _onChange();
    });
  }

  _onChange() async {
    final suggestions = await locationSearchAutocompleteRepository
        .fetchLocationSuggestions(controllerLocationSearchAutocomplete.text);

    if (!mounted) return;
    setState(() {
      listOfLocation = List<LocationSearchAutocompleteModel>.from(suggestions);
    });

    final location = await locationDetailsRepository.fetchLocationLatLng();

    if (suggestions.isNotEmpty) {
      if (!mounted) return;
      setState(() {
        locationDetails = [location];
      });
    }
  }

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
                    'Location Auto Complete',
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
          children: [
            TextField(
              controller: controllerLocationSearchAutocomplete,
              maxLines: null,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  vertical: 24,
                  horizontal: 8,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey.withAlpha(80),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.red,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                hintText: 'Search place',
              ),
              onTap: () {},
              onChanged: (value) {
                setState(() {});
              },
            ),
            Visibility(
              visible: controllerLocationSearchAutocomplete.text.isEmpty
                  ? false
                  : true,
              child: Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: listOfLocation.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () async {
                        String taskLocation = listOfLocation[index].description;
                        context.router.maybePop<String>(taskLocation);
                      },
                      child: ListTile(
                        title: Text(
                          listOfLocation[index].description,
                          // style: TextStyle(color: Colors.black),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Visibility(
              visible: controllerLocationSearchAutocomplete.text.isEmpty
                  ? true
                  : false,
              child: Container(
                margin: EdgeInsets.only(
                  top: 20,
                  bottom: 20,
                ),
                child: ElevatedButton(
                  onPressed: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.my_location, color: Colors.green),
                      SizedBox(width: 12),
                      Text(
                        'My Location',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
