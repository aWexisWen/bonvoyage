import 'package:bonvoyage/services/database_service.dart';
import 'package:flutter/material.dart';
import 'package:lab5shoesbrand/models/.dart';
import 'package:lab5shoesbrand/services/database_service.dart';

class buy_ticketFormPage extends StatefulWidget {
  const buy_ticketFormPage({Key? key, this.buy_ticket}) : super(key: key);
  final buy_ticket? buy_ticket;
  @override
  _buy_ticketFormPageState createState() => _buy_ticketFormPageState();
}

class _buy_ticketFormPageState extends State<buy_ticketFormPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final DatabaseServices _databaseService = DatabaseServices();

  @override
  void initState() {
    super.initState();
    if (widget.buy_ticket != null) {
      _nameController.text = widget.brand!.name;
      _descController.text = widget.brand!.description;
    }
  }

  Future<void> _onSave() async {
    final name = _nameController.text;
    final description = _descController.text;
    widget.brand == null
        ? await _databaseService.insertBrand(
            Brand(name: name, description: description),
          )
        : await _databaseService.updateBrand(
            Brand(
              id: widget.brand!.id,
              name: name,
              description: description,
            ),
          );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a new brand'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter name of the brand here',
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _descController,
              maxLines: 7,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter description about the brand here',
              ),
            ),
            const SizedBox(height: 16.0),
            SizedBox(
              height: 45.0,
              child: ElevatedButton(
                onPressed: _onSave,
                child: const Text(
                  'Save the Brand',
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
