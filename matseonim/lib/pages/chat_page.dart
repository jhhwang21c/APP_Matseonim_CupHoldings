import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

import 'package:matseonim/components/custom_app_bar.dart';
import 'package:matseonim/models/chat.dart';
import 'package:matseonim/models/user.dart';
import 'package:matseonim/pages/drawer_page.dart';

class ChatPage extends StatelessWidget {
  final MSIUser recipient;
  
  const ChatPage({Key? key, required this.recipient}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(showBackButton: true),
      drawer: DrawerPage(),
      body: FutureBuilder(
        future: MSIUser.init(),
        builder: (BuildContext context, AsyncSnapshot<MSIUser> snapshot) {
          if (!snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                alignment: Alignment.center,
                child: const CircularProgressIndicator()
              )
            );
          } else {
            final MSIUser user = snapshot.data!;

            return _ChatWidget(users: [user, recipient]);
          }
        }
      )
    );
  }
}

class _ChatWidget extends StatelessWidget {
  final List<MSIUser> users;
  
  const _ChatWidget({Key? key, required this.users}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: FutureBuilder(
        future: MSIRoom.init(users: users), 
        builder: (BuildContext context, AsyncSnapshot<MSIRoom> snapshot) {  
          if (!snapshot.hasData) {
            return SizedBox(
              child: Container(
                alignment: Alignment.center,
                child: const CircularProgressIndicator()
              )
            );
          } else {
            final MSIRoom room = snapshot.data!;

            return StreamBuilder<List<types.TextMessage>>(
              stream: room.getMessages(),
              builder: (BuildContext context, AsyncSnapshot<List<types.TextMessage>> snapshot) {
                if (!snapshot.hasData) {
                  return SizedBox(
                    child: Container(
                      alignment: Alignment.center,
                      child: const CircularProgressIndicator()
                    )
                  );
                } else {
                  List<types.TextMessage> messages = snapshot.data!;

                  return Chat(
                    messages: messages,
                    onSendPressed: /* TODO: ... */,
                    user: users[0].toChatUser(),
                  );
                }
              },
            );
          }
        },
      )
    );
  }
}