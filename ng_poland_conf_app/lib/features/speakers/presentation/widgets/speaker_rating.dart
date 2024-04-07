import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ng_poland_conf_app/core/blocks/conferences/conferences_cubit.dart';
import 'package:ng_poland_conf_app/features/speakers/domains/usecases/get_rate_for_speaker.dart';
import 'package:ng_poland_conf_app/features/speakers/domains/usecases/rate_speaker.dart';
import 'package:ng_poland_conf_app/features/speakers/presentation/bloc/speaker_rating_bloc.dart';
import 'package:ng_poland_conf_app/injectable.dart';
import 'package:rive/rive.dart';

class SpeakerRating extends StatefulWidget {
  static const String ratingFilePath = 'assets/animations/rive/stars.riv';

  final String id;
  final RiveFile ratingFile;

  const SpeakerRating({
    super.key,
    required this.id,
    required this.ratingFile,
  });

  @override
  State<SpeakerRating> createState() => _SpeakerRatingState();
}

class _SpeakerRatingState extends State<SpeakerRating> {
  final String ratingProperties = 'rating';
  final String isLoadingProperties = 'isLoading';
  final String stateMachineName = '5 Star';
  late final SpeakerRatingBloc _speakerRatingCubit;
  late StateMachineController _controller;
  Artboard? _riveArtboard;
  SMINumber? smiNumber;
  SMIBool? smiLoading;

  void onRiveEvent(RiveEvent event) {
    double rating = event.properties[ratingProperties] as double;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _speakerRatingCubit.add(
        SpeakerRatingEvent.rateSpeaker(
          rate: rating.toInt(),
        ),
      );
    });
  }

  @override
  void initState() {
    _speakerRatingCubit = SpeakerRatingBloc(
      getIt.get<ConferencesCubit>(),
      getIt.get<GetRateForSpeaker>(),
      getIt.get<RateSpeaker>(),
      widget.id,
    )..add(
        const SpeakerRatingEvent.getRateForSpeaker(),
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
      create: (_) => _speakerRatingCubit,
      child: BlocConsumer<SpeakerRatingBloc, SpeakerRatingState>(
        listener: (context, state) {
          state.whenOrNull(
            readyToRate: () => smiLoading?.value = false,
            rated: (rateForSpeaker) {
              smiLoading?.value = false;
              smiNumber?.value = rateForSpeaker.toDouble();
            },
          );
        },
        builder: (context, state) {
          final Artboard? riveArtboard = _riveArtboard;
          if (riveArtboard == null) return const SizedBox.shrink();
          return IgnorePointer(
            ignoring: state.maybeWhen(
              readyToRate: () => false,
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
