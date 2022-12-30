import 'package:flutter/material.dart';
import 'package:bonvoyage/models/ferry_ticket.dart';
import 'package:bonvoyage/services/database_service.dart';
import 'package:bonvoyage/models/users.dart';

class FerryTicketFormPage extends StatefulWidget {
  const FerryTicketFormPage({Key? key, this.ferry_ticket, this.user})
      : super(key: key);
  final FerryTicket? ferry_ticket;
  final User? user;
  @override
  _FerryTicketFormPageState createState() => _FerryTicketFormPageState();
}

enum Trip { oneway, returning }

class _FerryTicketFormPageState extends State<FerryTicketFormPage> {
  final TextEditingController _depart_dateController = TextEditingController();
  final TextEditingController _journeyController = TextEditingController();
  final TextEditingController _depart_routeController = TextEditingController();
  final TextEditingController _dest_routeController = TextEditingController();
  final TextEditingController _user_idController = TextEditingController();
  final DatabaseServices _databaseService = DatabaseServices();
  final _formKey = GlobalKey<FormState>();

  List<String> location = [
    'Penang',
    'Langkawi',
    'Singapore',
    'Batam',
    'Koh Lipe'
  ];
  String? selectedLocation = 'Penang';
  Trip? _character = Trip.oneway;

  DateTime date = DateTime(2022, 12, 24);

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
        title: const Text('FerryTicket'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Container(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  controller: _depart_dateController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter name of the FerryTicket here',
                  ),
                ),
                const SizedBox(height: 16.0),
                DropdownButton<String>(
                  hint: Text('depart route'),
                  value: selectedLocation,
                  items: location
                      .map((location) => DropdownMenuItem<String>(
                            value: location,
                            child: Text(
                              location,
                              style: TextStyle(fontSize: 24),
                            ),
                          ))
                      .toList(),
                  onChanged: (location) =>
                      setState(() => selectedLocation = location),
                ),
                const SizedBox(height: 16.0),
                ListTile(
                  title: const Text('One way'),
                  leading: Radio<Trip>(
                    value: Trip.oneway,
                    groupValue: _character,
                    onChanged: (Trip? value) {
                      setState(() {
                        _character = value;
                      });
                    },
                  ),
                ),
                ListTile(
                  title: const Text('Return'),
                  leading: Radio<Trip>(
                    value: Trip.returning,
                    groupValue: _character,
                    onChanged: (Trip? value) {
                      setState(() {
                        _character = value;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 16.0),
                SizedBox(
                  height: 45.0,
                  child: ElevatedButton(
                    onPressed: _onSave,
                    child: const Text(
                      'Purchase Ferry Ticket',
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
