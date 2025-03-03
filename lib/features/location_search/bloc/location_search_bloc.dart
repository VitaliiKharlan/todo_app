import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'location_search_event.dart';
part 'location_search_state.dart';

class LocationSearchBloc extends Bloc<LocationSearchEvent, LocationSearchState> {
  LocationSearchBloc() : super(LocationSearchInitialState()) {
    on<LocationSearchEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
