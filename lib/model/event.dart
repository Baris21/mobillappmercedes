import 'package:flutter/material.dart';

class Event {
  final String eventId;
  final String title;
  final String description;
  final DateTime from;
  final DateTime to;
  final String user;
  final String userimage;
  final String image;
  final DateTime date;
  //final Color backgroundColor;

  final bool limitedParticipation;
  final int numberOfPeople;

  const Event({
    required this.eventId,
    required this.title,
    required this.description,
    required this.from,
    required this.to,
    required this.numberOfPeople,
    required this.user,
    required this.userimage,
    required this.image,
    required this.date,
    // this.backgroundColor = Colors.lightGreen,
    required this.limitedParticipation,
  });

  Map<String, dynamic> createMap() {
    return {
      'eventId': eventId,
      'title': title,
      'description': description,
      'from': from,
      'to': to,
      'numberOfPeople': numberOfPeople,
      'limitedParticipation': limitedParticipation,
      'user': user,
      'userimage': userimage,
      'image': image,
      'date': date,
      //'backgroundColor': backgroundColor
    };
  }

  Event.fromFirestore(Map<String, dynamic> firestoreMap)
      : eventId = firestoreMap['eventId'],
        title = firestoreMap['title'],
        from = firestoreMap['from'],
        to = firestoreMap['to'],
        numberOfPeople = firestoreMap['numberOfPeople'],
        user = firestoreMap['user'],
        userimage = firestoreMap['userimage'],
        image = firestoreMap['image'],
        date = firestoreMap['date'],
        //backgroundColor = firestoreMap['backgroundColor'],
        limitedParticipation = firestoreMap['limitedParticipation'],
        description = firestoreMap['description'];
}
