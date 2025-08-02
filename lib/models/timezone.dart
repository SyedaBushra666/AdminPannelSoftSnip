class TimezoneItem {
  final String label;       // e.g. "Member's time zone"
  final String value;       // e.g. "PDT: America - Los Angeles"

  TimezoneItem(this.label, this.value);

  String get shortCode => value.split(':').first.trim(); // PDT
  String get fullLabel => '$label — $value';             // Full display
}
