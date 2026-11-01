import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ng_poland_conf_app/features/edition/domain/entities/event_item.dart';
import 'package:ng_poland_conf_app/features/edition/domain/entities/event_item_type.dart';
import 'package:ng_poland_conf_app/features/event/presentation/cubit/event_cubit.dart';
import 'package:ng_poland_conf_app/features/event/presentation/pages/event_page.dart';

import '../../../../helpers/page_on_phone.dart';

class _FakeEventCubit extends Cubit<EventState> implements EventCubit {
  _FakeEventCubit()
    : super(
        const EventLoaded(
          event: EventItem(
            id: 'e1',
            title: 'Keynote',
            confId: 'c1',
            type: 'talk',
            category: 'talk',
            shortDescription: null,
            description: 'What this talk is about.',
            startDate: null,
            endDate: null,
            speaker: null,
          ),
          hasDescription: true,
        ),
      );

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  testWidgets('the list leaves room for the navigation bar', (tester) async {
    await pumpPageOnPhone(
      tester,
      BlocProvider<EventCubit>(
        create: (_) => _FakeEventCubit(),
        child: const EventPage(track: EventItemType.ngPoland),
      ),
    );

    expect(listBottomPadding(tester), greaterThan(navigationBarHeight));
  });
}
