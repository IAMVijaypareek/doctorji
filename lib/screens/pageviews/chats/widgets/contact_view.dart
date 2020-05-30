import 'package:doctorji/models/entity_model/contact.dart';
import 'package:doctorji/models/entity_model/user.dart';
import 'package:doctorji/provider/user_provider.dart';
import 'package:doctorji/resources/auth_methods.dart';
import 'package:doctorji/resources/chat_methods/chat_methods.dart';
import 'package:doctorji/screens/chatscreens/chat_screen.dart';
import 'package:doctorji/screens/chatscreens/widgets/cached_image.dart';
import 'package:doctorji/screens/pageviews/chats/widgets/last_message_container.dart';
import 'package:doctorji/screens/pageviews/chats/widgets/online_dot_indicator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:doctorji/widgets/custom_tile.dart';

class ContactView extends StatelessWidget {
  final Contact contact;
  final AuthMethods _authMethods = AuthMethods();
  ContactView(this.contact);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _authMethods.getUserDetailsById(contact.uid),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          User user = snapshot.data;
          return ViewLayout(contact: user);
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}

class ViewLayout extends StatelessWidget {
  final User contact;
  final ChatMethods _chatMethods = ChatMethods();

  ViewLayout({
    @required this.contact,
  });

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);

    return CustomTile(
      mini: false,
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatScreen(
              receiver: contact,
            ),
          )),
      title: Text(
        (contact != null ? contact.name : null) != null ? contact.name : "..",
        style:
            TextStyle(color: Colors.white, fontFamily: "Arial", fontSize: 19),
      ),
      subtitle: LastMessageContainer(
        stream: _chatMethods.fetchLastMessageBetween(
          senderId: userProvider.getUser.uid,
          receiverId: contact.uid,
        ),
      ),
      leading: Container(
        constraints: BoxConstraints(maxHeight: 60, maxWidth: 60),
        child: Stack(
          children: <Widget>[
            CachedImage(
              contact.profilePhoto,
              radius: 80,
              isRound: true,
            ),
            OnlineDotIndicator(
              uid: contact.uid,
            ),
          ],
        ),
      ),
    );
  }
}
