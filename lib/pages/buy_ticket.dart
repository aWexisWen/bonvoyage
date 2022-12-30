import 'package:bonvoyage/models/ferry_ticket.dart';
import 'package:bonvoyage/services/database_service.dart';
import 'package:flutter/material.dart';
import 'package:bonvoyage/models/ferry_ticket.dart';
import 'package:bonvoyage/services/database_service.dart';
import 'package:bonvoyage/models/users.dart';

class buy_ticketFormPage extends StatefulWidget {
  const buy_ticketFormPage({Key? key, this.ferry_ticket, this.user})
      : super(key: key);
  final FerryTicket? ferry_ticket;
  final User? user;
  @override
  _buy_ticketFormPageState createState() => _buy_ticketFormPageState();
}

enum Trip { oneway, returning }

class _buy_ticketFormPageState extends State<buy_ticketFormPage> {
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
        title: const Text('Ferry Ticket'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${date.year}/${date.month}/${date.day}',
                  style: TextStyle(fontSize: 24),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  child: Text('Select Date'),
                  onPressed: () async {
                    DateTime? newDate = await showDatePicker(
                      context: context,
                      initialDate: date,
                      firstDate: DateTime(2020),
                      lastDate: DateTime(2030),
                    );

                    if (newDate == null) return;

                    setState(() => date = newDate);
                  },
                ),
                DropdownButton<String>(
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
                      'Purchase Ticket',
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
