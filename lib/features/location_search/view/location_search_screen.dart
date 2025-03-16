import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:todo_app/features/create_new_task/data/models/location_details.dart';
import 'package:todo_app/features/create_new_task/data/repositories/place_details_repository.dart';
import 'package:todo_app/features/location_search/bloc/location_search_bloc.dart';
import 'package:todo_app/features/task_details/data/repositories/geo_position_search_for_weather_repository.dart';

@RoutePage()
class LocationSearchScreen extends StatefulWidget {
  LocationSearchScreen({
    super.key,
  });

  @override
  State<LocationSearchScreen> createState() => _LocationSearchScreenState();
}

class _LocationSearchScreenState extends State<LocationSearchScreen> {
  final placeDetailsRepository = PlaceDetailsRepository();
  TextEditingController controllerLocationSearch = TextEditingController();
  final geoPositionSearchForWeatherRepository =
      ImplGeoPositionSearchForWeatherRepository();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LocationSearchBloc>(
      create: (context) => LocationSearchBloc(
        placeDetailsRepository,
        geoPositionSearchForWeatherRepository,
      ),
      child: Builder(builder: (context) {
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
                  controller: controllerLocationSearch,
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
                    context
                        .read<LocationSearchBloc>()
                        .add(LocationSearchTextChangeEvent(value));
                  },
                ),
                Expanded(
                  child: BlocBuilder<LocationSearchBloc, LocationSearchState>(
                    builder: (context, state) {
                      if (state is LocationSearchLoadingState) {
                        return Center(
                          child: SizedBox(
                              height: 40,
                              width: 40,
                              child: CircularProgressIndicator()),
                        );
                      } else if (state is LocationSearchLoadedState) {
                        final suggestions = state.suggestions;
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: suggestions.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () async {
                                final selectedLocation = suggestions[index];

                                context.read<LocationSearchBloc>().add(
                                      LocationSelectEvent(selectedLocation),
                                    );
                                context.router.maybePop<LocationDetailsModel>(
                                    suggestions[index]);
                              },
                              child: ListTile(
                                title: Text(
                                  suggestions[index].description ??
                                      'no description',
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            );
                          },
                        );
                      } else if (state is LocationSearchFailureState) {
                        return Center(
                          child: Text(state.exception.toString()),
                        );
                      }
                      return SizedBox.shrink();
                    },
                  ),
                ),
                Visibility(
                  visible: controllerLocationSearch.text.isEmpty ? true : false,
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
      }),
    );
  }
}
