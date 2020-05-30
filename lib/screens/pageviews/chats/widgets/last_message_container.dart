import 'package:doctorji/models/entity_model/message.dart';
import 'package:flutter/material.dart';

class LastMessageContainer extends StatelessWidget {
  final stream;
  LastMessageContainer({this.stream});
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: stream,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          var docList = snapshot.data.documents;

          if (docList.isNotEmpty) {
            Message message = Message.fromMap(docList.last.data);
            return SizedBox(
              width: MediaQuery.of(context).size.width * 0.6,
              child: Text(
                message.message,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),
            );
          }
          return Text("No message",
           style: TextStyle(
              color: Colors.grey,
              fontSize: 14,
          ));
        }
        return Text(
          "..",
          style: TextStyle(
            color: Colors.grey,
            fontSize: 14,
          ),
        );
      },
    );
  }
}
