import 'package:flutter/material.dart';
import 'package:bonvoyage/models/ferry_ticket.dart';
import 'package:bonvoyage/services/database_service.dart';
import 'package:bonvoyage/models/users.dart';
import 'package:date_time_picker/date_time_picker.dart';

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

  List<String> depart = [
    'Penang',
    'Langkawi',
    'Singapore',
    'Batam',
    'Koh Lipe'
  ];
  String? selectedDepart = 'Penang';

  List<String> destination = [
    'Penang',
    'Langkawi',
    'Singapore',
    'Batam',
    'Koh Lipe'
  ];
  String? selectedDestination = 'Penang';
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
                /*Text(
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
                ),*/
                /*return DropdownButtonFormField(
      items: location.map((String category) {
        return new DropdownMenuItem(
            value: category,
            child: Row(
              children: <Widget>[
                //Icon(Icons.co_present_rounded),
                Text(category),
              ],
            ));
      }).toList(),
      onChanged: (newValue) {
        // do other stuff with _category
        setState(() => selectedLocation = newValue!);
      },
      value: selectedLocation,
      decoration: InputDecoration(
        labelText: 'Select depart route',
        hintText: 'Select depart route',
        border: OutlineInputBorder(),
        icon: Icon(Icons.co_present_rounded),
      ),
    ),*/
                //depart dropdown
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: 'Depart route',
                    hintText: 'Depart route',
                  ),
                  value: selectedDepart,
                  items: depart
                      .map((location) => DropdownMenuItem<String>(
                            value: location,
                            child: Text(
                              location,
                              style: TextStyle(fontSize: 12),
                            ),
                          ))
                      .toList(),
                  onChanged: (location) =>
                      setState(() => selectedDepart = location),
                ),
                //destination dropdown
                const SizedBox(height: 16.0),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: 'Destination route',
                    hintText: 'Destination route',
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                            width: 3, color: Colors.lightBlue)),
                  ),
                  value: selectedDestination,
                  items: destination
                      .map((location) => DropdownMenuItem<String>(
                            value: location,
                            child: Text(
                              location,
                              style: TextStyle(fontSize: 12),
                            ),
                          ))
                      .toList(),
                  onChanged: (location) =>
                      setState(() => selectedDestination = location),
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DateTimePicker(
                    type: DateTimePickerType.dateTimeSeparate,
                    dateMask: 'd MMM, yyyy',
                    controller: _depart_dateController,
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2100),
                    icon: const Icon(Icons.event),
                    dateLabelText: "Check In Date",
                    timeLabelText: "Time",
                    onChanged: (val) => print(val),
                    validator: (val) => val!.isEmpty ? "Required" : null,
                    onSaved: (val) => print(val),
                  ),
                ),
                const SizedBox(height: 16.0),
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
