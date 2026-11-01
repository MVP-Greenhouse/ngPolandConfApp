part of 'admin_cubit.dart';

const _adminCopyWithSentinel = Object();

class AdminState {
  const AdminState({
    this.isAdmin = false,
    this.selectedConfId,
    this.selectedTrack = EventItemType.ngPoland,
    this.availableTracks = const [],
    this.config,
    this.ranking = const <EventVoteRank>[],
    this.notice,
    this.loading = false,
  });

  final bool isAdmin;
  final String? selectedConfId;
  final EventItemType selectedTrack;
  final List<EventItemType> availableTracks;
  final EngagementConfig? config;
  final List<EventVoteRank> ranking;

  /// One-off feedback for the last admin action; cleared once shown.
  final AppNotice? notice;
  final bool loading;

  AdminState copyWith({
    bool? isAdmin,
    String? selectedConfId,
    EventItemType? selectedTrack,
    List<EventItemType>? availableTracks,
    EngagementConfig? config,
    List<EventVoteRank>? ranking,
    Object? notice = _adminCopyWithSentinel,
    bool? loading,
  }) {
    return AdminState(
      isAdmin: isAdmin ?? this.isAdmin,
      selectedConfId: selectedConfId ?? this.selectedConfId,
      selectedTrack: selectedTrack ?? this.selectedTrack,
      availableTracks: availableTracks ?? this.availableTracks,
      config: config ?? this.config,
      ranking: ranking ?? this.ranking,
      notice: identical(notice, _adminCopyWithSentinel)
          ? this.notice
          : notice as AppNotice?,
      loading: loading ?? this.loading,
    );
  }
}
