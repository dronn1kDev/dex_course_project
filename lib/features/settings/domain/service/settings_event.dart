abstract class SettingsEvent {
  const SettingsEvent();
}

class ChangeLocaleEvent extends SettingsEvent {
  final int newLocaleIndex;

  const ChangeLocaleEvent(this.newLocaleIndex);
}
