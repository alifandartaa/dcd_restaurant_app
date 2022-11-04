import 'package:dcd_restaurant_app/provider/preference_provider.dart';
import 'package:dcd_restaurant_app/provider/schedulling_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  static const routeName = '/settings_page';

  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<PreferencesProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          body: SafeArea(
            child: Material(
              child: ListTile(
                title: const Text('Scheduling Restaurant Today'),
                trailing: Consumer<SchedulingProvider>(
                  builder: (context, scheduled, _) {
                    return Switch.adaptive(
                        value: provider.isDailyRestaurantActive,
                        onChanged: (value) async {
                          scheduled.scheduledNews(value);
                          provider.enableDailyNews(value);
                        });
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
