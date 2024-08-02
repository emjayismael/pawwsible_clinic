import 'package:flutter/material.dart';

class PetForm extends StatefulWidget {
  @override
  _PetFormState createState() => _PetFormState();
}

class _PetFormState extends State<PetForm> {
  final TextEditingController petNameController = TextEditingController();
  final TextEditingController breedController = TextEditingController();
  final TextEditingController speciesController = TextEditingController();
  final TextEditingController sexController = TextEditingController();
  final TextEditingController birthdateController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController colorMarkingsController = TextEditingController();
  final TextEditingController ownerNameController = TextEditingController();
  final TextEditingController contactNoController = TextEditingController();
  DateTime? selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        birthdateController.text = "${picked.toLocal()}".split(' ')[0];
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 233, 237, 241),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(8.0),
                child: Text('Pet Name:'),
              ),
              Container(
                padding: EdgeInsets.all(8.0),
                child: Text('Breed:'),
              ),
              Container(
                padding: EdgeInsets.all(8.0),
                child: Text('Species:'),
              ),
              Container(
                padding: EdgeInsets.all(8.0),
                child: Text('Sex:'),
              ),
              Container(
                padding: EdgeInsets.all(8.0),
                child: Text('Birthdate:'),
              ),
              Container(
                padding: EdgeInsets.all(8.0),
                child: Text('Age:'),
              ),
              Container(
                padding: EdgeInsets.all(8.0),
                child: Text('Color Markings:'),
              ),
              Container(
                padding: EdgeInsets.all(8.0),
                child: Text('Owner Name:'),
              ),
              Container(
                padding: EdgeInsets.all(8.0),
                child: Text('Contact Number:'),
              ),
             
              Container(
                padding: EdgeInsets.all(8.0),
                child: Text('Date Appointment:'),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
