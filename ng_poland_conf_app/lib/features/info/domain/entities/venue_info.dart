import 'package:ng_poland_conf_app/features/edition/domain/entities/agenda.dart';

/// Practical information about the edition: where, when and tickets.
class VenueInfo {
  const VenueInfo({
    required this.venue,
    required this.city,
    required this.ticketsUrl,
    required this.days,
    required this.daysLabel,
  });

  final Venue? venue;

  /// For example `Warsaw, PL`.
  final String? city;
  final String ticketsUrl;
  final List<AgendaDay> days;

  /// For example `3 CONSECUTIVE DAYS`.
  final String daysLabel;

  bool get isEmpty => venue == null && ticketsUrl.isEmpty && days.isEmpty;
}
