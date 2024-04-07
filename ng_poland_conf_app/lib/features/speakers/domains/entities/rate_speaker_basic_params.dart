abstract class RateSpeakerBasicParams {
  final String confId;
  final String speakerId;

  String get keyForLocalStorage => confId + speakerId;

  RateSpeakerBasicParams({
    required this.confId,
    required this.speakerId,
  });
}
