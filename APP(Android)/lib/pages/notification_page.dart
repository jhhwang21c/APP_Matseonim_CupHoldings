import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:matseonim/components/custom_app_bar.dart';
import 'package:matseonim/components/custom_circle_avatar.dart';
import 'package:matseonim/models/user.dart';
import 'package:matseonim/pages/chat_page.dart';
import 'package:matseonim/pages/drawer_page.dart';
import 'package:matseonim/pages/my_msi_page.dart';
import 'package:matseonim/pages/profile_page.dart';
import 'package:matseonim/utils/media.dart';
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

            return SizedBox(
              width: getScreenWidth(context),
              height: getScreenHeight(context),
              child: ListView(
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
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

class _NotificationWidget extends StatelessWidget {
  final MSINotification notification;
  final MSIUser user;

  const _NotificationWidget({
    Key? key, 
    required this.notification,
    required this.user
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: notification.getMessage(), 
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) { 
        if (!snapshot.hasData) {
          return Container(
            height: getScreenHeight(context) * 0.15,
            alignment: Alignment.center,
            child: const CircularProgressIndicator()
          );
        } else {
          final String message = snapshot.data!;

          return InkWell(
            onTap: () async {
              await user.deleteNotification(id: notification.id);

              if (notification.type == MSINotificationType.acceptedRequest) {
                await Get.to(MyMSIPage());
              } else if (notification.type == MSINotificationType.newChatMessages) {
                await Get.to(
                  ChatPage(
                    recipient: await MSIUser.init(uid: notification.uid)
                  )
                );
              } else if (notification.type == MSINotificationType.newReview) {
                await Get.to(ProfilePage());
              }
            },
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Row(
                children: [
                  FutureBuilder(
                    future: MSIUser.init(uid: notification.uid),
                    builder: (BuildContext context, AsyncSnapshot<MSIUser> snapshot) { 
                      if (!snapshot.hasData) {
                        return Container(
                          alignment: Alignment.center,
                          child: const CircularProgressIndicator()
                        );
                      } else {
                        final MSIUser sender = snapshot.data!;

                        return CustomCircleAvatar(
                          size: 60, 
                          url: sender.avatarUrl ?? ""
                        );
                      }
                    },
                  ),
                  SizedBox(width: 16),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          message,
                          style: const TextStyle(
                            fontSize: 16,
                          )
                        ),
                        SizedBox(height: 4),
                        (notification.payload.isNotEmpty)
                          ? Text(
                            "> ${notification.payload.split("\n")[0]}",
                            style: const TextStyle(
                              color: msiPrimaryColor,
                              fontSize: 16,
                            )
                          )
                          : Container()
                      ]
                    )
                  )
                ]
              )
            )
          );
        }
      }    
    );
  }
}

class _NotificationListView extends StatelessWidget {
  final MSIUser user;

  const _NotificationListView({
    Key? key, 
    required this.user
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
            return Container(
              width: getScreenWidth(context),
              height: getScreenHeight(context) - 48,
              alignment: Alignment.center,
              child: Text(
                "새로운 알림이 없습니다.",
                style: const TextStyle(
                  fontSize: 16
                ),
                textAlign: TextAlign.center
              )
            );
          } else {
            return Expanded(
              child: ListView.separated(
                scrollDirection: Axis.vertical,
                itemCount: notifications.length,
                itemBuilder: (context, i) {
                  return _NotificationWidget(
                    notification: notifications[i],
                    user: user
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