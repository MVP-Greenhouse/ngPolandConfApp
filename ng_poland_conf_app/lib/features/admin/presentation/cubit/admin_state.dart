part of 'admin_cubit.dart';

const _adminCopyWithSentinel = Object();

class AdminState {
  const AdminState({
    this.isAdmin = false,
    this.latestConfId,
    this.selectedConfId,
    this.confIds = const <String>[],
    this.selectedTrack = EventItemType.ngPoland,
    this.availableTracks = const [EventItemType.ngPoland, EventItemType.jsPoland],
    this.config,
    this.ranking = const <EventVoteRank>[],
    this.message,
    this.loading = false,
  });

  final bool isAdmin;
  final String? latestConfId;
  final String? selectedConfId;
  final List<String> confIds;
  final EventItemType selectedTrack;
  final List<EventItemType> availableTracks;
  final EngagementConfig? config;
  final List<EventVoteRank> ranking;
  final String? message;
  final bool loading;

  AdminState copyWith({
    bool? isAdmin,
    String? latestConfId,
    String? selectedConfId,
    List<String>? confIds,
    EventItemType? selectedTrack,
    List<EventItemType>? availableTracks,
    EngagementConfig? config,
    List<EventVoteRank>? ranking,
    Object? message = _adminCopyWithSentinel,
    bool? loading,
  }) {
    return AdminState(
      isAdmin: isAdmin ?? this.isAdmin,
      latestConfId: latestConfId ?? this.latestConfId,
      selectedConfId: selectedConfId ?? this.selectedConfId,
      confIds: confIds ?? this.confIds,
      selectedTrack: selectedTrack ?? this.selectedTrack,
      availableTracks: availableTracks ?? this.availableTracks,
      config: config ?? this.config,
      ranking: ranking ?? this.ranking,
      message: identical(message, _adminCopyWithSentinel)
          ? this.message
          : message as String?,
      loading: loading ?? this.loading,
    );
  }
}
