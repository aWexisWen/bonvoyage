import 'package:bonvoyage/common_widgets/ft_builder.dart';
import 'package:bonvoyage/common_widgets/ft_selector.dart';
import 'package:bonvoyage/pages/login.dart';
import 'package:bonvoyage/models/ferry_ticket.dart';
import 'package:bonvoyage/pages/ticket_form_page.dart';
import 'package:bonvoyage/pages/register.dart';
import 'package:bonvoyage/common_widgets/formField.dart';
import 'package:flutter/material.dart';
import 'package:bonvoyage/models/users.dart';
import 'package:bonvoyage/services/database_service.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../common_widgets/buttons.dart';

class ViewTicketPage extends StatefulWidget {
  const ViewTicketPage({Key? key}) : super(key: key);
  @override
  _ViewTicketPageState createState() => _ViewTicketPageState();
}

class _ViewTicketPageState extends State<ViewTicketPage> {
  final DatabaseServices _databaseService = DatabaseServices();
  Future<List<FerryTicket>> _getFerryTicket() async {
    return await _databaseService.getFerryTickets();
  }

  // Future<void> _getUsers() async {
  //   return await _databaseService.registerUser();
  // }

  Future<void> _onFerryTicketDelete(FerryTicket ferryTicket) async {
    await _databaseService.deleteFerryTicket(ferryTicket);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 1,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('FerryTicket Database'),
          centerTitle: true,
          bottom: const TabBar(
            tabs: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: Text('FerryTickets'),
              ),
              // Padding(
              //   padding: EdgeInsets.symmetric(vertical: 16.0),
              //   child: Text('Users'),
              // ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            FerryTicketBuilder(
              future: _getFerryTicket(),
              onEdit: (value) {
                {
                  Navigator.of(context)
                      .push(
                        MaterialPageRoute(
                          builder: (_) =>
                              FerryTicketFormPage(ferry_ticket: value),
                          fullscreenDialog: true,
                        ),
                      )
                      .then((_) => setState(() {}));
                }
              },
              onDelete: _onFerryTicketDelete,
            ),
            //  BrandBuilder(
            //     future: _getBrands(),
            //     onEdit: (value) {
            //       {
            //         Navigator.of(context)
            //             .push(
            //               MaterialPageRoute(
            //                 builder: (_) => BrandFormPage(brand: value),
            //                 fullscreenDialog: true,
            //               ),
            //             )
            //             .then((_) => setState(() {}));
            //       }
            //     },
            //     onDelete: _onBrandDelete,
            //   ),
          ],
        ),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // const SizedBox(height: 12.0),
            // FloatingActionButton(
            //   onPressed: () {
            //     Navigator.of(context)
            //         .push(
            //           MaterialPageRoute(
            //             builder: (context) => const FerryTicketFormPage(),
            //             fullscreenDialog: true,
            //           ),
            //         )
            //         .then((_) => setState(() {}));
            //   },
            //   heroTag: 'addBrand',
            //   child: const FaIcon(FontAwesomeIcons.plus),
            // ),
            const SizedBox(height: 12.0),
            FloatingActionButton(
              onPressed: () {
                Navigator.of(context)
                    .push(
                      MaterialPageRoute(
                        builder: (context) => const FerryTicketFormPage(),
                        fullscreenDialog: true,
                      ),
                    )
                    .then((_) => setState(() {}));
              },
              heroTag: 'addFerryTicket',
              child: const FaIcon(FontAwesomeIcons.bagShopping),
            ),
          ],
        ),
      ),
    );
  }
}
