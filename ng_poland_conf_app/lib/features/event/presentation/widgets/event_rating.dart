import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ng_poland_conf_app/core/blocks/conferences/conferences_cubit.dart';
import 'package:ng_poland_conf_app/features/event/domains/usecases/get_rate_for_event.dart';
import 'package:ng_poland_conf_app/features/event/domains/usecases/rate_event.dart';
import 'package:ng_poland_conf_app/features/event/presentation/bloc/event_rating_bloc.dart';
import 'package:ng_poland_conf_app/injectable.dart';
import 'package:rive/rive.dart';

class EventRating extends StatefulWidget {
  static const String ratingFilePath = 'assets/animations/rive/stars.riv';

  final String id;
  final String eventItemType;
  final RiveFile ratingFile;

  const EventRating({
    super.key,
    required this.id,
    required this.eventItemType,
    required this.ratingFile,
  });

  @override
  State<EventRating> createState() => _EventRatingState();
}

class _EventRatingState extends State<EventRating> {
  final String ratingProperties = 'rating';
  final String isLoadingProperties = 'isLoading';
  final String stateMachineName = '5 Star';
  late final EventRatingBloc _eventRatingCubit;
  late StateMachineController _controller;
  Artboard? _riveArtboard;
  SMINumber? smiNumber;
  SMIBool? smiLoading;

  void onRiveEvent(RiveEvent event) {
    double rating = event.properties[ratingProperties] as double;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _eventRatingCubit.add(
        EventRatingEvent.rateEvent(
          rate: rating.toInt(),
        ),
      );
    });
  }

  @override
  void initState() {
    _eventRatingCubit = EventRatingBloc(
      getIt.get<ConferencesCubit>(),
      getIt.get<GetRateForEvent>(),
      getIt.get<RateEvent>(),
      widget.id,
      widget.eventItemType,
    )..add(
        const EventRatingEvent.getRateForEvent(),
      );
    final Artboard artboard = widget.ratingFile.mainArtboard;
    _controller = StateMachineController.fromArtboard(
      artboard,
      stateMachineName,
    )!;
    artboard.addController(_controller);
    _controller.addEventListener(onRiveEvent);
    smiNumber = _controller.findSMI<SMINumber>(ratingProperties);
    smiLoading = _controller.findSMI<SMIBool>(isLoadingProperties);
    setState(() => _riveArtboard = artboard);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _controller.removeEventListener(onRiveEvent);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => _eventRatingCubit,
      child: BlocConsumer<EventRatingBloc, EventRatingState>(
        listener: (context, state) {
          state.whenOrNull(
            readyToRate: () => smiLoading?.value = false,
            rated: (rateForEvent) {
              smiLoading?.value = false;
              smiNumber?.value = rateForEvent.toDouble();
            },
          );
        },
        builder: (context, state) {
          final Artboard? riveArtboard = _riveArtboard;
          if (riveArtboard == null) return const SizedBox.shrink();
          return IgnorePointer(
            ignoring: state.maybeWhen(
              readyToRate: () => false,
              rated: (_) => false,
              orElse: () => true,
            ),
            child: SizedBox(
              width: 200,
              height: 30,
              child: Rive(
                artboard: riveArtboard,
                fit: BoxFit.cover,
                enablePointerEvents: true,
              ),
            ),
          );
        },
      ),
    );
  }
}
