import 'dart:convert';
import 'package:flutter/widgets.dart';

////////change attributes based on madames question!!!!!!!!!!!!!!!!!!!!!!!
class FerryTicket {
  final int book_id;
  final String depart_date;
  final String journey;
  final String depart_route;
  final String dest_route;
  final int user_id;

  FerryTicket({
    required this.book_id,
    required this.depart_date,
    required this.journey,
    required this.depart_route,
    required this.dest_route,
    required this.user_id,
  });

  Map<String, dynamic> toMap() {
    return {
      'book_id': book_id,
      'depart_date': depart_date,
      'journey': journey,
      'depart_route': depart_route,
      'dest_route': dest_route,
      'user_id': user_id,
    };
  }

  factory FerryTicket.fromMap(Map<String, dynamic> map) {
    return FerryTicket(
      book_id: map['book_id']?.toInt() ?? 0,
      depart_date: map['depart_date'] ?? "",
      journey: map['journey'] ?? "",
      depart_route: map['depart_route'] ?? "",
      dest_route: map['dest_route'] ?? "",
      user_id: map['user_id'] ?? "",
    );
  }

  String toJson() => json.encode(toMap());
  factory FerryTicket.fromJson(String source) => FerryTicket.fromMap(json.decode(source));
  @override
  String toString() {
    return 'FactoryTicket(book_id: $book_id, depart_date: $depart_date, journey: $journey, depart_route: $depart_route, dest_route: $dest_route, user_id: $user_id)';
  }
}
