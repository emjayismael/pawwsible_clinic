import 'package:flutter/material.dart';
import 'package:my_first_app/view_patient.dart';

class ViewPatientRecordsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 238, 240, 241),
      appBar: AppBar(
        title: Text('Patient Records'),
      ),
      body: PetForm(), // Display PetForm content
    );
  }
}