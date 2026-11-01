import 'package:flutter_test/flutter_test.dart';
import 'package:ng_poland_conf_app/features/workshops/domain/services/workshop_labels.dart';

void main() {
  test('tab label drops the trailing Day', () {
    expect(workshopTabLabel('Hands-on Workshops Day'), 'HANDS-ON WORKSHOPS');
    expect(workshopTabLabel('Day'), 'DAY');
    expect(workshopTabLabel('Workshops'), 'WORKSHOPS');
  });

  test('date parts come from the agenda date label', () {
    expect(workshopDateParts('Nov 16, 2026'), (month: 'Nov', day: '16'));
    expect(workshopDateParts('November'), (month: 'November', day: ''));
  });

  test('price label lists available currencies', () {
    expect(
      workshopPriceLabel(pricePln: 499, priceEur: 119),
      '499 PLN / 119 EUR',
    );
    expect(workshopPriceLabel(priceEur: 119), '119 EUR');
    expect(workshopPriceLabel(), isEmpty);
  });
}
