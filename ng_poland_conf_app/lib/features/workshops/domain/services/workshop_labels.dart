/// `Hands-on Workshops Day` → `HANDS-ON WORKSHOPS`.
String workshopTabLabel(String dayName) {
  const suffix = ' Day';
  final name = dayName.endsWith(suffix) && dayName.length > suffix.length
      ? dayName.substring(0, dayName.length - suffix.length)
      : dayName;
  return name.toUpperCase();
}

/// Splits an agenda date label such as `Nov 16, 2026` into month and day.
({String month, String day}) workshopDateParts(String dateLabel) =>
    switch (dateLabel.split(',').first.trim().split(' ')) {
      [final month, final day, ...] => (month: month, day: day),
      [final month] => (month: month, day: ''),
      _ => (month: '', day: ''),
    };

/// `499 PLN / 119 EUR`, or empty when the workshop has no price.
String workshopPriceLabel({int? pricePln, int? priceEur}) => [
  if (pricePln != null) '$pricePln PLN',
  if (priceEur != null) '$priceEur EUR',
].join(' / ');
