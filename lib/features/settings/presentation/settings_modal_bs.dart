import 'package:dex_course_temp/core/domain/intl/generated/l10n.dart';
import 'package:dex_course_temp/features/settings/domain/service/settings_event.dart';
import 'package:dex_course_temp/features/settings/domain/service/settings_service.dart';
import 'package:dex_course_temp/theme/color_collection.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:reactive_variables/reactive_variables.dart';

class SettingsModalBottomSheet extends StatelessWidget {
  final SettingsService settingsService;

  SettingsModalBottomSheet({super.key, required this.settingsService});

  final isDarkThemeActive = false.rv;

  BoxDecoration get _modalDecoration => const BoxDecoration(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(28),
        topRight: Radius.circular(28),
      ),
      // color: ColorCollection.surfaceContainerLow,
      color: Colors.red);

  Widget get _languageDropDownBuilder => DropdownMenu(
        initialSelection: settingsService.currentLocale,
        onSelected: (newLocale) {
          if (newLocale == null) return;

          final localeIndex =
              settingsService.supportedLocaleList.indexOf(newLocale);

          settingsService.add(ChangeLocaleEvent(localeIndex));
        },
        dropdownMenuEntries: [
          for (var i = 0; i < settingsService.supportedLocaleList.length; i++)
            DropdownMenuEntry(
              value: settingsService.supportedLocaleList[i],
              label: settingsService.supportedLocaleList[i].name,
            ),
        ],
      );

  Widget _themeSwitcherBuilder(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            S.of(context).darkTheme,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          isDarkThemeActive.observer(
            (context, value) => Switch(
              value: value,
              onChanged: (value) => isDarkThemeActive(value),
            ),
          ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      // decoration: _modalDecoration,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _modalHeaderBuilder(context),
          const SizedBox(height: 16),
          _languageDropDownBuilder,
          const SizedBox(height: 24),
          const Divider(),
          const SizedBox(height: 24),
          _themeSwitcherBuilder(context),
          SizedBox(height: MediaQuery.of(context).padding.bottom),
        ],
      ),
    );
  }

  Widget _modalHeaderBuilder(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            S.of(context).settings,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          TextButton(
            onPressed: context.pop,
            child: Text(
              S.of(context).done,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: ColorCollection.primary,
                  ),
            ),
          ),
        ],
      );
}
