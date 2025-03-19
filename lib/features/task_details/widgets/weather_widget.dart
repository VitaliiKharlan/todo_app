import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

import 'package:todo_app/features/create_new_task/bloc/entities/task_entity.dart';
import 'package:todo_app/features/task_details/bloc/weather_bloc.dart';
import 'package:todo_app/features/task_details/data/repositories/weather_repository.dart';
import 'package:todo_app/main_prod.dart';
import 'package:todo_app/ui/theme/app_colors.dart';
import 'package:todo_app/ui/theme/app_images.dart';
import 'package:todo_app/ui/theme/app_text_style.dart';

class WeatherWidget extends StatefulWidget {
  const WeatherWidget({
    super.key,
    required this.task,
  });

  final Task task;

  @override
  State<WeatherWidget> createState() => _WeatherWidgetState();
}

class _WeatherWidgetState extends State<WeatherWidget> {
  Widget _getWeatherIcon(int weatherIcon) {
    const iconMap = {
      1: AppImages.smallIconSun,
      2: AppImages.smallIconPartlyCloudy,
      3: AppImages.smallIconCloud,
      4: AppImages.smallIconRain,
      5: AppImages.smallIconSnow,
      6: AppImages.smallIconSun,
      7: AppImages.smallIconPartlyCloudy,
      8: AppImages.smallIconCloud,
      9: AppImages.smallIconRain,
      10: AppImages.smallIconSnow,
    };
    if (iconMap.containsKey(weatherIcon)) {
      return Image.asset(iconMap[weatherIcon]!);
    } else {
      return SizedBox(
          height: 48,
          width: 48,
          child: Lottie.asset('assets/lottie_animation/hare.json'));
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.task.taskLocation == null) {
      return const SizedBox.shrink();
    }
    return BlocProvider(
      create: (context) {
        final weatherBloc = WeatherBloc(getIt<WeatherRepository>());
        weatherBloc.add(WeatherSelectEvent(widget.task.taskLocation!));
        return weatherBloc;
      },
      child: BlocBuilder<WeatherBloc, WeatherState>(
        builder: (context, state) {
          if (state is WeatherLoadingState) {
            return Center(child: CircularProgressIndicator());
          } else if (state is WeatherSelectedFailureState) {
            return Text(
              'Error: ${state.exception}',
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            );
          } else if (state is WeatherSelectedState) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 12,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Transform.scale(
                          scale: 1.25,
                          child: _getWeatherIcon(state.weatherCurrentIcon),
                        ),
                        SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              '${state.localizedName}, ${state.countryName}',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              state.weatherCurrentDescription.toString(),
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[600],
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              DateFormat("HH:mm").format(
                                  state.weatherLocalObservationDateTime),
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[500],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 60),
                        Text(
                          '${state.weatherCurrentTemperature.toStringAsFixed(0)}\u00B0',
                          style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 8),
                  _HourlyForecastWidget(),
                  SizedBox(height: 16),
                ],
              ),
            );
          } else {
            return SizedBox.shrink();
          }
        },
      ),
    );
  }
}

class _HourlyForecastWidget extends StatelessWidget {
  const _HourlyForecastWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: SizedBox(
        height: 120,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: 24,
          itemExtent: 60,
          itemBuilder: (BuildContext context, int index) {
            return _HourlyForecastItemWidget();
          },
        ),
      ),
    );
  }
}

class _HourlyForecastItemWidget extends StatelessWidget {
  const _HourlyForecastItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 4,
        vertical: 4,
      ),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: AppColors.description,
          border: Border.all(color: Colors.black.withAlpha(50)),
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: Colors.blue.withAlpha(50),
              blurRadius: 8,
              offset: const Offset(4, 2),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(
            Radius.circular(8.0),
          ),
          clipBehavior: Clip.hardEdge,
          child: Column(
            children: [
              const SizedBox(height: 12),
              const Image(
                image: AssetImage(AppImages.smallIconSun),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 4),
                      RichText(
                        softWrap: false,
                        text: TextSpan(
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                            children: [
                              TextSpan(text: '18 '),
                              TextSpan(
                                text: '\u00B0C',
                                style: TextStyle(fontSize: 12),
                              ),
                            ]),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '09:00',
                        style: AppTextStyle.description.copyWith(
                          color: Colors.red,
                          fontSize: 10,
                        ),
                        maxLines: 1,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
