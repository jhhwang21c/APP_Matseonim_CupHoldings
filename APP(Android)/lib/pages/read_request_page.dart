import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:matseonim/components/custom_alert_dialog.dart';
import 'package:matseonim/components/custom_app_bar.dart';
import 'package:matseonim/components/custom_elevated_button.dart';
import 'package:matseonim/components/custom_profile_widgets.dart';
import 'package:matseonim/models/request.dart';
import 'package:matseonim/models/user.dart';
import 'package:matseonim/pages/drawer_page.dart';
import 'package:matseonim/pages/main_page.dart';

class ReadRequestPage extends StatelessWidget {
  final MSIRequest request;

  const ReadRequestPage({Key? key, required this.request}) : super(key: key);

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
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: ListView(
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Text(
                      "의뢰 내용", 
                      style: TextStyle(fontSize: 32)
                    ),
                  ),
                  MidProfile(uid: request.uid),
                  SizedBox(height: 20),
                  Text(
                    "의뢰 제목: ${request.title}", 
                    style: const TextStyle(fontSize: 32)
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "요청 분야: ${request.field}", 
                    style: const TextStyle(fontSize: 16)
                  ),
                  const SizedBox(height: 10),
                  Text(
                    request.description, 
                    style: const TextStyle(fontSize: 16),
                    textAlign: TextAlign.justify,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomElevatedButton(
                      text: "요청 수락",
                      textStyle: const TextStyle(
                        fontSize: 16,
                        color: Colors.white
                      ),
                      color: Theme.of(context).primaryColor,
                      funPageRoute: () async { 
                        await user.acceptRequest(request: request);

                        MSIUser requester = await MSIUser.init(uid: request.uid);
                        
                        await requester.sendNotification(
                          type: MSINotificationType.acceptedRequest, 
                          sender: user, 
                          payload: ""
                        );

                        await Get.dialog(
                          const CustomAlertDialog(
                            message: "요청 수락이 완료되었습니다."
                          )
                        );

                        Get.to(MainPage());
                      }
                    )
                  )
                ],
              ),
            );
          }
        }
      )
    );
  }
}
