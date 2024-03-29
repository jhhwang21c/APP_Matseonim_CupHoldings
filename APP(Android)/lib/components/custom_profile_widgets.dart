import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:matseonim/components/custom_circle_avatar.dart';
import 'package:matseonim/components/custom_elevated_button.dart';
import 'package:matseonim/models/user.dart';
import 'package:matseonim/pages/chat_page.dart';
import 'package:matseonim/pages/profile_page.dart';
import 'package:matseonim/pages/review_page.dart';
import 'package:matseonim/utils/media.dart';

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
                    child: const CircularProgressIndicator()));
          } else {
            final MSIUser user = snapshot.data!;

            return Column(children: [
              CustomCircleAvatar(size: 180, url: user.avatarUrl ?? ""),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(user.name ?? "",
                      style: const TextStyle(
                        fontSize: 48,
                      )),
                  SizedBox(
                    width: 8,
                  ),
                  Text.rich(TextSpan(
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                      children: [
                        const WidgetSpan(
                            child: Icon(
                          Icons.star,
                          size: 16.0,
                          color: Colors.amber,
                        )),
                        TextSpan(
                            text: user.rating!.toStringAsFixed(1))
                      ]))
                ],
              ),
              SizedBox(height: 16),
              Text(user.baseName ?? "",
                  style: const TextStyle(
                    fontSize: 32,
                  )),
              SizedBox(height: 16),
              Text("전문 분야: ${user.profession ?? "(없음)"}",
                  style: const TextStyle(
                    fontSize: 16,
                  )),
              SizedBox(height: 10),
              Text("경력",
                  style: TextStyle(
                    fontSize: 16,
                    decoration: TextDecoration.underline,
                  )),
              SizedBox(height: 3),
              Text(
                user.resume ?? "(없음)",
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 10),
              Row(
              mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 150, 
                    height: 55,
                    child: CustomElevatedButton(
                        text: "채팅하기",
                        color: Colors.lightBlue,
                        funPageRoute: () {
                          Get.to(ChatPage(recipient: user));
                        }),
                  ),
                  SizedBox(width: 10),
                  SizedBox(
                    width: 150, 
                    height: 55,
                    child: CustomElevatedButton(
                        text: "리뷰하기",
                        color: Colors.cyan[200],
                        funPageRoute: () {
                          Get.to(
                            ReviewPage(
                              revieweeId: uid!,
                            )
                          );
                        }),
                  ),
                ],
              ),
            ],
            );
          }
        });
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
                    child: const CircularProgressIndicator()));
          } else {
            final MSIUser user = snapshot.data!;

            return Container(
              margin: EdgeInsets.symmetric(vertical: 12.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      CustomCircleAvatar(
                        size: 120, 
                        url: user.avatarUrl ?? ""
                      ),
                      const SizedBox(width: 30),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                user.name ?? "",
                                style: const TextStyle(
                                  fontSize: 32,
                                )
                              ),
                              SizedBox(width: 8),
                              Text.rich(
                                TextSpan(
                                  style: const TextStyle(
                                    fontSize: 16,
                                  ),
                                  children: [
                                    const WidgetSpan(
                                      child: Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      )
                                    ),
                                    TextSpan(
                                      text: user.rating!
                                        .toStringAsFixed(1)
                                    )
                                  ]
                                )
                              )
                            ],
                          ),
                          SizedBox(height: 10),
                          Text(user.baseName ?? "?",
                              style: const TextStyle(
                                fontSize: 16,
                              )),
                          SizedBox(height: 10),
                          Text("분야: ${user.interest ?? ""}",
                              style: const TextStyle(
                                fontSize: 16,
                              )),
                          SizedBox(height: 4),
                          TextButton(
                            onPressed: () {
                              Get.to(ProfilePage(uid: user.uid));
                            },
                            child: Text("자세히 >>"),
                          )
                        ]
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
  final double? imageSize;

  const SmallProfile({Key? key, this.uid, this.imageSize}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: MSIUser.init(uid: uid),
        builder: (BuildContext context, AsyncSnapshot<MSIUser> snapshot) {
          if (!snapshot.hasData) {
            return SizedBox(
                child: Container(
                    alignment: Alignment.center,
                    child: const CircularProgressIndicator()));
          } else {
            final MSIUser user = snapshot.data!;

            return InkWell(
              onTap: () { Get.to(ProfilePage(uid: user.uid)); },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomCircleAvatar(size: imageSize ?? 60, url: user.avatarUrl ?? ""),
                    SizedBox(height: 10),
                    Text(user.name ?? "",
                      style: const TextStyle(
                        fontSize: 16,
                      )
                    ),
                    
                    Text.rich(
                      TextSpan(
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                        children: [
                          const WidgetSpan(
                            child: Padding(
                              padding: EdgeInsets.only(right: 4.0),
                              child: Icon(
                                Icons.star,
                                size: 16.0,
                                color: Colors.amber,
                              )
                            )
                          ),
                          TextSpan(
                            text: user.rating!.toStringAsFixed(1)
                          )
                        ]
                      )
                    )
                  ],
                )
              ),
            );
          }
        });
  }
}

class SmallProfile2 extends StatelessWidget {
  final String? uid;

  final double? imageSize;

  const SmallProfile2({Key? key, this.uid, this.imageSize}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: MSIUser.init(uid: uid),
      builder: (BuildContext context, AsyncSnapshot<MSIUser> snapshot) {
        if (!snapshot.hasData) {
          return SizedBox(
              child: Container(
                  alignment: Alignment.center,
                  child: const CircularProgressIndicator()));
        } else {
          final MSIUser user = snapshot.data!;

          return GestureDetector(
            onTap: () {
              Get.to(ProfilePage(uid: user.uid));
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomCircleAvatar(
                    size: imageSize ?? 60, 
                    url: user.avatarUrl ?? ""
                  ),
                  SizedBox(height: 10),
                  Text(user.name ?? "",
                    style: const TextStyle(
                      fontSize: 16,
                    )
                  ),
                ],
              )
            ),
          );
        }
      }
    );
  }
}

class ReviewProfile extends StatelessWidget {
  final String uid;

  const ReviewProfile({
    Key? key, 
    required this.uid
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: MSIUser.init(uid: uid),
      builder: (BuildContext context, AsyncSnapshot<MSIUser> snapshot) {
        if (!snapshot.hasData) {
          return SizedBox(
              child: Container(
                  alignment: Alignment.center,
                  child: const CircularProgressIndicator()));
        } else {
          final MSIUser user = snapshot.data!;

          return Container(
              margin: EdgeInsets.symmetric(horizontal: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomCircleAvatar(size: 80, url: user.avatarUrl ?? ""),
                  SizedBox(width: 10),
                  Text(user.name ?? "",
                    style: const TextStyle(
                      fontSize: 32,
                    )
                  ),
                ],
              ),
          );
        }
      }
    );
  }
}

class MidProfileListView extends StatelessWidget {
  final List<dynamic> uidList;

  const MidProfileListView({Key? key, required this.uidList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: getScreenWidth(context),
      height: getScreenHeight(context),
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: uidList.length,
        itemBuilder: (context, i) {
          return FutureBuilder(
            future: MSIUser.init(uid: uidList[i]),
            builder:
                (BuildContext context, AsyncSnapshot<MSIUser> snapshot) {
              if (!snapshot.hasData) {
                return SizedBox(
                    child: Container(
                        alignment: Alignment.center,
                        child: const CircularProgressIndicator()));
              } else {
                return MidProfile(uid: snapshot.data!.uid);
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

class SmallProfileListView extends StatelessWidget {
  final List<dynamic> uidList;

  const SmallProfileListView({Key? key, required this.uidList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 120,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: uidList.length,
            itemBuilder: (context, i) {
              return FutureBuilder(
                  future: MSIUser.init(uid: uidList[i]),
                  builder:
                      (BuildContext context, AsyncSnapshot<MSIUser> snapshot) {
                    if (!snapshot.hasData) {
                      return Container(
                          alignment: Alignment.center,
                          child: const CircularProgressIndicator());
                    } else {
                      return SmallProfile(uid: snapshot.data!.uid);
                    }
                  });
            }));
  }
}
