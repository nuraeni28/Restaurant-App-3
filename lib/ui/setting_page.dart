import 'dart:io';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:yess_nutrion/provider/preferences_provider.dart';
import 'package:yess_nutrion/provider/scheduling_provider.dart';

class SettingPageResto extends StatelessWidget {
  static const routeName = '/setting_resto';

  SettingPageResto({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: BodySettingPageResto(),
    );
  }
}

class BodySettingPageResto extends StatelessWidget {
  const BodySettingPageResto({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(children: <Widget>[
      Container(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 30, left: 30),
                    child: Text(
                      'Setting Restaurant ',
                      style: TextStyle(
                          fontSize: 24,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
                padding: EdgeInsets.only(left: 20),
                child: Consumer<PreferencesProvider>(
                    builder: (context, provider, child) {
                  return ListView(
                    shrinkWrap: true,
                    children: [
                      Material(
                        child: ListTile(
                          title: Text(
                            'Restaurant Notification',
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                          subtitle: Text(
                            "Enable notification",
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          trailing: Consumer<SchedulingProvider>(
                            builder: (context, scheduled, _) {
                              return Switch.adaptive(
                                value: provider.isDailyNotificationActive,
                                onChanged: (value) async {
                                  scheduled.scheduledResto(value);
                                  provider.enableDailyNotification(value);
                                },
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  );
                }))
          ]))
    ]));
  }
}

      //       Column(
      //         crossAxisAlignment: CrossAxisAlignment.start,
      //         mainAxisSize: MainAxisSize.max,
      //         children: [
      //           Text(
      //             'Setting',
      //             style: Theme.of(context).textTheme.headline5,
      //           ),
      //           const SizedBox(
      //             height: 6,
      //           ),
      //           Text(
      //             'Restaurant app settings',
      //             style: Theme.of(context).textTheme.subtitle1,
      //           ),
      //           const SizedBox(
      //             height: 20.0,
      //           ),
      //         ],
      //       ),
      //       const SizedBox(
      //         height: 20.0,
      //       ),
      //       Consumer<PreferencesProvider>(
      //         builder: (context, provider, child) {
      //           return ListView(
      //             shrinkWrap: true,
      //             children: [
      //               Material(
      //                 child: ListTile(
      //                   title: Text(
      //                     'Restaurant Notification',
      //                     style: Theme.of(context).textTheme.subtitle1,
      //                   ),
      //                   subtitle: Text(
      //                     "Enable notification",
      //                     style: Theme.of(context).textTheme.bodyText1,
      //                   ),
      //                   trailing: Consumer<SchedulingProvider>(
      //                       builder: (context, scheduled, _) {
      //                     return Switch.adaptive(
      //                       value: provider.isDailyNotificationActive,
      //                       onChanged: (value) async {
      //                         if (Platform.isIOS) {
      //                           customDialog(context);
      //                         } else {
      //                           scheduled.scheduledRestaurant(value);
      //                           provider.enableDailyNotification(value);
      //                         }
      //                       },
      //                     );
      //                   }),
      //                 ),
      //               ),
      //             ],
      //           );
      //         },
      //       )
      //     ],
      //   ),
      // ),
 
