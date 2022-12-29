import 'package:bonvoyage/models/ferry_ticket.dart';
import 'package:bonvoyage/services/database_service.dart';
import 'package:flutter/material.dart';
import 'package:bonvoyage/models/ferry_ticket.dart';
import 'package:bonvoyage/services/database_service.dart';

class buy_ticketFormPage extends StatefulWidget {
  const buy_ticketFormPage({Key? key, this.ferry_ticket}) : super(key: key);
  final FerryTicket? ferry_ticket;
  @override
  _buy_ticketFormPageState createState() => _buy_ticketFormPageState();
}

class _buy_ticketFormPageState extends State<buy_ticketFormPage> {
  final TextEditingController _depart_dateController = TextEditingController();
  final TextEditingController _journeyController = TextEditingController();
  final TextEditingController _depart_routeController = TextEditingController();
  final TextEditingController _dest_routeController = TextEditingController();
  final TextEditingController _user_idController = TextEditingController();
  final DatabaseServices _databaseService = DatabaseServices();
   List<String> location = [
    'Penang',
    'Langkawi',
    'Singapore',
    'Batam',
    'Koh Lipe'
  ];
  String? selectedLocation = 'Penang';

  @override
  void initState() {
    super.initState();
    if (widget.ferry_ticket != null) {
      _depart_dateController.text = widget.ferry_ticket!.depart_date;
      _journeyController.text = widget.ferry_ticket!.journey;
      _depart_routeController.text = widget.ferry_ticket!.depart_route;
      _dest_routeController.text = widget.ferry_ticket!.dest_route;
      _user_idController.text = widget.ferry_ticket!.user_id as String;
    }
  }

  Future<void> _onSave() async {
    final depart_date = _depart_dateController.text;
    final journey = _journeyController.text;
    final depart_route = _depart_routeController.text;
    final dest_route = _depart_dateController.text;

    widget.ferry_ticket == null
        ? await _databaseService.insertFerryTicket(FerryTicket(
            depart_date: depart_date,
            journey: journey,
            depart_route: depart_route,
            dest_route: dest_route))
        : await _databaseService.editFerryTicket(FerryTicket(
            depart_date: depart_date,
            journey: journey,
            depart_route: depart_route,
            dest_route: dest_route));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ferry Ticket'),
        centerTitle: true,
      ),
      body: Center(
        child: DropdownButton<String>(
          value: selectedLocation,
          items: location
          .map((location) => DropdownMenuItem<String>(
            value: location,
            child: Text(location, style: TextStyle(fontSize: 24),),
          ))
      .toList(),
          onChanged: (location) => setState(()=>selectedLocation = location),
    )
    ),
  );
  }
}
