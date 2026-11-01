import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ng_poland_conf_app/features/info/domain/entities/venue_info.dart';
import 'package:ng_poland_conf_app/features/info/presentation/cubit/info_cubit.dart';
import 'package:ng_poland_conf_app/features/info/presentation/pages/info_page.dart';

import '../../../../helpers/page_on_phone.dart';

class _FakeInfoCubit extends Cubit<InfoState> implements InfoCubit {
  _FakeInfoCubit()
    : super(
        const InfoLoaded(
          VenueInfo(
            venue: null,
            city: null,
            ticketsUrl: 'https://example.com/tickets',
            days: [],
            daysLabel: '',
          ),
        ),
      );

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  testWidgets('the list leaves room for the navigation bar', (tester) async {
    await pumpPageOnPhone(
      tester,
      BlocProvider<InfoCubit>(
        create: (_) => _FakeInfoCubit(),
        child: const InfoPage(),
      ),
    );

    expect(listBottomPadding(tester), greaterThan(navigationBarHeight));
  });
}
