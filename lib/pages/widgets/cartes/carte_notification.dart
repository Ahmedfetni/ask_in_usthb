import 'package:flutter/material.dart';
import '../../../models/une_notification.dart';

class CarteNotification extends StatefulWidget {
  UneNotification notif;
  CarteNotification({Key? key, required this.notif}) : super(key: key);

  @override
  State<CarteNotification> createState() => _CarteNotificationState();
}

class _CarteNotificationState extends State<CarteNotification> {
  @override
  Widget build(BuildContext context) {
    String text =
        widget.notif.reponse ? widget.notif.corp[1] : widget.notif.corp[0];
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: ListTile(
        title: Wrap(
          children: [
            Text(
              text,
              style: const TextStyle(color: Colors.lightBlue),
            ),
          ],
        ),
        trailing: const Icon(Icons.more_vert),
      ),
    );
  }
}
