import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:matseonim/components/custom_app_bar.dart';
import 'package:matseonim/components/custom_circle_avatar.dart';
import 'package:matseonim/models/user.dart';
import 'package:matseonim/pages/chat_page.dart';
import 'package:matseonim/pages/drawer_page.dart';
import 'package:matseonim/pages/my_msi_page.dart';
import 'package:matseonim/pages/profile_page.dart';
import 'package:matseonim/utils/theme.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(showBackButton: true),
      drawer: DrawerPage(),
      body: FutureBuilder(
        future: MSIUser.init(),
        builder: (BuildContext context, AsyncSnapshot<MSIUser> snapshot) {
          if (!snapshot.hasData) {
            return SizedBox(
              child: Container(
                alignment: Alignment.center,
                child: const CircularProgressIndicator()
              )
            );
          } else {
            final MSIUser user = snapshot.data!;

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ListView(
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Text(
                      "새로운 알림", 
                      style: TextStyle(fontSize: 32)
                    ),
                  ),
                  _NotificationListView(user: user)
                ]
              )
            );
          }
        },
      ),
    );
  }
}

class _NotificationListView extends StatelessWidget {
  final MSIUser user;

  const _NotificationListView({
    Key? key, required this.user
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: user.getNotifications(), 
      builder: (BuildContext context, AsyncSnapshot<List<MSINotification>> snapshot) { 
        if (!snapshot.hasData) {
          return Container(
            alignment: Alignment.center,
            child: const CircularProgressIndicator()
          );
        } else {
          final List<MSINotification> notifications = snapshot.data!;

          if (notifications.isEmpty) {
            return Center(
              child: Text(
                "새로운 알림이 없습니다.",
                style: const TextStyle(
                  fontSize: 32
                )
              )
            );
          } else {
            return Container(
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.height,
              child: ListView.separated(
                scrollDirection: Axis.vertical,
                itemCount: notifications.length,
                itemBuilder: (context, i) {
                  return FutureBuilder(
                    future: notifications[i].getMessage(), 
                    builder: (BuildContext context, AsyncSnapshot<String> snapshot) { 
                      if (!snapshot.hasData) {
                        return Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Container(
                            alignment: Alignment.center,
                            child: const CircularProgressIndicator()
                          )
                        );
                      } else {
                        final String message = snapshot.data!;

                        return InkWell(
                          onTap: () async {
                            await user.deleteNotification(id: notifications[i].id);

                            if (notifications[i].type == MSINotificationType.acceptedRequest) {
                              await Get.to(MyMSIPage());
                            } else if (notifications[i].type == MSINotificationType.newChatMessages) {
                              await Get.to(
                                ChatPage(
                                  recipient: await MSIUser.init(uid: notifications[i].uid)
                                )
                              );
                            } else if (notifications[i].type == MSINotificationType.newReview) {
                              await Get.to(ProfilePage());
                            }
                          },
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Row(
                              children: [
                                CustomCircleAvatar(
                                  size: 60, 
                                  url: user.avatarUrl ?? ""
                                ),
                                SizedBox(width: 16),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      message,
                                      style: const TextStyle(
                                        fontSize: 16,
                                      )
                                    ),
                                    (notifications[i].payload.isNotEmpty)
                                      ? Text(
                                          "> ${notifications[i].payload}",
                                          style: const TextStyle(
                                            color: msiPrimaryColor,
                                            fontSize: 16,
                                          )
                                        )
                                      : Container()
                                  ]
                                )
                              ],
                            )
                          )
                        );
                      }
                    }    
                  );
                },
                separatorBuilder: (context, i) { 
                  return Divider(
                    thickness: 1,
                    color: Colors.grey,
                  );
                },
              )
            );
          }
        }
      },
    );
  }
}