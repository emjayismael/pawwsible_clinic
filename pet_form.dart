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
  final TextEditingController appointmentDateController = TextEditingController();
  DateTime? selectedDate;
  DateTime? selectedAppointmentDate;
  final List<String> availableTimes = [
    '09:00 AM - 10:00 AM',
    '10:00 AM - 11:00 AM',
    '11:00 AM - 12:00 PM',
    '01:00 PM - 02:00 PM',
    '02:00 PM - 03:00 PM',
    '03:00 PM - 04:00 PM',
  ];
  String? selectedAvailableTime;

  Future<void> _selectDate(BuildContext context, TextEditingController controller, {DateTime? initialDate}) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        if (controller == birthdateController) {
          selectedDate = picked;
        } else if (controller == appointmentDateController) {
          selectedAppointmentDate = picked;
        }
        controller.text = "${picked.toLocal()}".split(' ')[0];
      });
    }
  }

  void _submitForm() {
    if (ownerNameController.text.isNotEmpty) {
      Navigator.pushNamed(
        context,
        '/patient_records',
        arguments: PatientRecordArguments(
          petName: petNameController.text,
          breed: breedController.text,
          species: speciesController.text,
          sex: sexController.text,
          birthdate: birthdateController.text,
          age: ageController.text,
          colorMarkings: colorMarkingsController.text,
          ownerName: ownerNameController.text,
          contactNo: contactNoController.text,
          appointmentDate: appointmentDateController.text,
          availableTime: selectedAvailableTime ?? '',
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      appBar: AppBar(
        title: Text(
          'Pet Form',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Color(0xFF6A1B9A),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 8.0,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(
                            'https://cdn-icons-png.flaticon.com/512/616/616408.png',
                          ),
                          radius: 30,
                        ),
                        SizedBox(width: 10),
                        Text(
                          'Pawssible',
                          style: TextStyle(
                            fontSize: 24,
                            color: Color(0xFF6A1B9A),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    _buildTextField(petNameController, 'Pet Name'),
                    _buildTextField(breedController, 'Breed'),
                    _buildTextField(speciesController, 'Species'),
                    _buildTextField(sexController, 'Sex'),
                    _buildTextFieldWithDatePicker(
                      controller: birthdateController,
                      label: 'Birthdate',
                      context: context,
                      selectedDate: selectedDate,
                    ),
                    _buildTextField(ageController, 'Age'),
                    _buildTextField(colorMarkingsController, 'Color Markings'),
                    _buildTextField(ownerNameController, 'Owner Name'),
                    _buildTextField(contactNoController, 'Contact Number'),
                    _buildTextFieldWithDatePicker(
                      controller: appointmentDateController,
                      label: 'Appointment Date',
                      context: context,
                      selectedDate: selectedAppointmentDate,
                    ),
                    SizedBox(height: 20),
                    _buildDropdownField(
                      value: selectedAvailableTime,
                      label: 'Available Time',
                      items: availableTimes,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedAvailableTime = newValue;
                        });
                      },
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _submitForm,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF6A1B9A),
                        padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child: Text(
                        'Submit',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Colors.grey),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          filled: true,
          fillColor: Color(0xFFF5F5F5),
        ),
      ),
    );
  }

  Widget _buildTextFieldWithDatePicker({
    required TextEditingController controller,
    required String label,
    required BuildContext context,
    DateTime? selectedDate,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Colors.grey),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          filled: true,
          fillColor: Color(0xFFF5F5F5),
          suffixIcon: IconButton(
            icon: Icon(Icons.calendar_today),
            onPressed: () => _selectDate(context, controller, initialDate: selectedDate),
          ),
        ),
      ),
    );
  }

  Widget _buildDropdownField({
    required String? value,
    required String label,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: DropdownButtonFormField<String>(
        value: value,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Colors.grey),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          filled: true,
          fillColor: Color(0xFFF5F5F5),
        ),
        items: items.map((String item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(item),
          );
        }).toList(),
        onChanged: onChanged,
      ),
    );
  }
}

class PatientRecordArguments {
  final String petName;
  final String breed;
  final String species;
  final String sex;
  final String birthdate;
  final String age;
  final String colorMarkings;
  final String ownerName;
  final String contactNo;
  final String appointmentDate;
  final String availableTime;

  PatientRecordArguments({
    required this.petName,
    required this.breed,
    required this.species,
    required this.sex,
    required this.birthdate,
    required this.age,
    required this.colorMarkings,
    required this.ownerName,
    required this.contactNo,
    required this.appointmentDate,
    required this.availableTime,
  });
}
