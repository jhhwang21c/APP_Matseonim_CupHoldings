import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:matseonim/components/custom_circle_avatar.dart';
import 'package:matseonim/components/custom_elevated_button.dart';
import 'package:matseonim/models/user.dart';
import 'package:matseonim/pages/profile_page.dart';

class LargeProfile extends StatelessWidget {
  final String? uid;

  const LargeProfile({Key? key, this.uid}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: MSIUser.init(uid: uid),
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

          return Column(
            children: [
              CustomCircleAvatar(
                size: 250, 
                url: user.avatarUrl ?? ""
              ),
              const SizedBox(height: 40),
              Text(user.name ?? "",
                  style: const TextStyle(
                    fontSize: 48,
                  )),
              SizedBox(height: 16),
              Text(user.baseName ?? "",
                  style: const TextStyle(
                    fontSize: 32,
                  )),
              SizedBox(height: 16),
              Text(
                "분야: ${user.interest ?? "(없음)"}",
                style: const TextStyle(
                  fontSize: 16,
                )
              ),
              SizedBox(height: 10),
              Text(
                "경력: ${user.resume ?? "(없음)"}",
                style: const TextStyle(
                  fontSize: 16,
                )
              ),
              SizedBox(height: 10),
              CustomElevatedButton(
                text: "채팅하기",
                color: Colors.lightBlue,
                funPageRoute: () {}
              ),
            ]
          );
        }
      }
    );
  }
}

class MidProfile extends StatelessWidget {
  final String? uid;

  const MidProfile({Key? key, this.uid}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: MSIUser.init(uid: uid),
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

          return Container(
            margin: EdgeInsets.symmetric(vertical: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Row(
                      children: [
                        CustomCircleAvatar(size: 120, url: user.avatarUrl ?? ""),
                        const SizedBox(width: 40),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              user.name ?? "?",
                              style: const TextStyle(
                                fontSize: 32,
                              )
                            ),
                            SizedBox(height: 10),
                            Text(
                              user.baseName ?? "?",
                              style: const TextStyle(
                                fontSize: 16,
                              )
                            ),
                            SizedBox(height: 10),
                            Text(
                              "분야: ${user.interest ?? ""}",
                              style: const TextStyle(
                                fontSize: 16,
                              )
                            ),
                            SizedBox(height: 4),
                            TextButton(
                              onPressed: () {
                                Get.to(
                                  ProfilePage(
                                    uid: user.uid
                                  )
                                );
                              },
                              child: Text("자세히 >>"),
                            )
                          ]
                        )
                      ]
                    ),
                    SizedBox(height: 10),
                    CustomElevatedButton(
                      text: "채팅하기",
                      color: Colors.lightBlue,
                      funPageRoute: () {}
                    )
                  ]
                )
              ]
            )
          );
        }
      }
    );
  }
}

class SmallProfile extends StatelessWidget {
  final String? uid;
  
  const SmallProfile({Key? key, this.uid}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: MSIUser.init(uid: uid),
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

          return Container(
            margin: EdgeInsets.symmetric(horizontal: 12.0),
            child: Column(
              children: [
                CustomCircleAvatar(size: 60, url: user.avatarUrl ?? ""),
                SizedBox(height: 10),
                Text(
                  user.name ?? "",
                  style: const TextStyle(
                    fontSize: 16
                  )
                ),
                Text(
                  user.profession ?? "",
                  style: TextStyle(
                    fontSize: 16
                  ),
                ),
              ],
            )
          );
        }
      }
    );
  }
}

class MidProfileListView extends StatelessWidget {
  final List<dynamic> uidList;

  const MidProfileListView({
    Key? key, 
    required this.uidList
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: uidList.length,
        itemBuilder: (context, i) {
          return FutureBuilder(
            future: MSIUser.init(uid: uidList[i]),
            builder: (BuildContext context, AsyncSnapshot<MSIUser> snapshot) {
              if (!snapshot.hasData) {
                return SizedBox(
                  child: Container(
                    alignment: Alignment.center,
                    child: const CircularProgressIndicator()
                  )
                );
              } else {
                return MidProfile(uid: snapshot.data!.uid);
              }
            }
          );
        }
      )
    );
  }
}

class SmallProfileListView extends StatelessWidget {
  final List<dynamic> uidList;

  const SmallProfileListView({
    Key? key, 
    required this.uidList
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 108,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: uidList.length,
        itemBuilder: (context, i) {
          return FutureBuilder(
            future: MSIUser.init(uid: uidList[i]),
            builder: (BuildContext context, AsyncSnapshot<MSIUser> snapshot) {
              if (!snapshot.hasData) {
                return Container(
                  alignment: Alignment.center,
                  child: const CircularProgressIndicator()
                );
              } else {
                return SmallProfile(uid: snapshot.data!.uid);
              }
            }
          );
        }
      )
    );
  }
}