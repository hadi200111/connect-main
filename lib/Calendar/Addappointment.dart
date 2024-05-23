import 'package:flutter/material.dart';
import 'package:CampusConnect/Calendar/Appointments.dart';
import 'package:CampusConnect/Calendar/AppointmentDetailsPage.dart';
import 'package:CampusConnect/Calendar/CalendarPage.dart';
import 'package:CampusConnect/main.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:time_picker_spinner/time_picker_spinner.dart';

class AddAppointment extends StatefulWidget {
  const AddAppointment({Key? key}) : super(key: key);

  @override
  _AddAppointmentState createState() => _AddAppointmentState();
}

class _AddAppointmentState extends State<AddAppointment> {
  late TextEditingController subjectController;
  late TextEditingController descriptionController;
  late TextEditingController appointmentLengthController;
  late TextEditingController locationController;
  late TextEditingController notesController;

  String selectedUnit = 'Minutes';
  List<String> units = ['Days', 'Hours', 'Minutes'];

  @override
  void initState() {
    super.initState();
    subjectController = TextEditingController();
    descriptionController = TextEditingController();
    appointmentLengthController = TextEditingController();
    locationController = TextEditingController();
    notesController = TextEditingController();
  }

  @override
  void dispose() {
    subjectController.dispose();
    descriptionController.dispose();
    appointmentLengthController.dispose();
    locationController.dispose();
    notesController.dispose();
    super.dispose();
  }

  DateTime selectedDate = DateTime.now();
  DateTime dateTime = DateTime.now();
  String dropdownValue = 'Private';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Appointment'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    onPressed: _selectDate,
                    icon: const Icon(Icons.calendar_today),
                    tooltip: 'Select Date',
                    color: Colors.deepPurple,
                  ),
                  IconButton(
                    onPressed: _selectTime,
                    icon: const Icon(Icons.access_time),
                    tooltip: 'Select Time',
                    color: Colors.deepPurple,
                  ),
                  if (Globals.roll == "Doctor") ...[
                    DropdownButton<String>(
                      value: dropdownValue,
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownValue = newValue!;
                        });
                      },
                      items: Globals.Schedule.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Row(
                            children: [
                              Icon(value == 'Private' ? Icons.lock : Icons.public),
                              const SizedBox(width: 8),
                              Text(value),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ],
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: subjectController,
                decoration: _inputDecoration('Subject'),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: descriptionController,
                decoration: _inputDecoration('Description'),
                minLines: 5,
                maxLines: null,
                keyboardType: TextInputType.multiline,
              ),
              const SizedBox(height: 16.0),
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: TextFormField(
                      controller: appointmentLengthController,
                      decoration: _inputDecoration('Length'),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  Expanded(
                    flex: 2,
                    child: DropdownButtonFormField<String>(
                      value: selectedUnit,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedUnit = newValue!;
                        });
                      },
                      items: units.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: locationController,
                decoration: _inputDecoration('Location'),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: notesController,
                decoration: _inputDecoration('Notes'),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Submit'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: Colors.deepPurple,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String labelText) {
    return InputDecoration(
      labelText: labelText,
      border: OutlineInputBorder(),
      fillColor: Colors.grey[200],
      filled: true,
    );
  }

  void _selectDate() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: 300,
          child: SfDateRangePicker(
            onSelectionChanged: (args) {
              setState(() {
                selectedDate = args.value;
              });
            },
            selectionMode: DateRangePickerSelectionMode.single,
          ),
        );
      },
    );
  }

  void _selectTime() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: 300,
          child: TimePickerSpinner(
            locale: const Locale('en', ''),
            time: dateTime,
            is24HourMode: false,
            isShowSeconds: false,
            itemHeight: 80,
            normalTextStyle: const TextStyle(fontSize: 24),
            highlightedTextStyle: const TextStyle(
              fontSize: 24,
              color: Colors.blue,
            ),
            isForce2Digits: true,
            onTimeChange: (time) {
              setState(() {
                dateTime = time;
              });
            },
          ),
        );
      },
    ).then((_) {
      setState(() {
        dateTime = DateTime(
          dateTime.year,
          dateTime.month,
          dateTime.day,
          dateTime.hour,
          dateTime.minute,
        );
      });
    });
  }

  void _submitForm() async {
    if (_validateForm()) {
      Appointments appointment = _createAppointment();
      await writeAppointment(appointment);
      _showAlertDialog('Success', 'Appointment added successfully.');
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AppointmentDetailsPage(appointment: appointment)),
      );
    } else {
      _showAlertDialog('Error', 'Please fill in all required fields.');
    }
  }

  bool _validateForm() {
    return subjectController.text.isNotEmpty &&
        descriptionController.text.isNotEmpty &&
        appointmentLengthController.text.isNotEmpty &&
        locationController.text.isNotEmpty;
  }

  Appointments _createAppointment() {
    String myid = Globals.userID;
    final appointment = Appointments(
      id: myid,
      subject: subjectController.text,
      description: descriptionController.text,
      date: selectedDate,
      startTime: dateTime,
      appointmentLength: _calculateAppointmentLength(),
      location: locationController.text,
      notes: notesController.text.isNotEmpty ? notesController.text : null,
      status: dropdownValue,
    );

    return appointment;
  }

  int _calculateAppointmentLength() {
    int length = int.parse(appointmentLengthController.text);
    if (selectedUnit == 'Hours') {
      length *= 60; // Convert hours to minutes
    } else if (selectedUnit == 'Days') {
      length *= 24 * 60; // Convert days to minutes
    }
    return length;
  }

  Future<void> writeAppointment(Appointments appointment) async {
    try {
      CollectionReference appointmentsCollection =
      FirebaseFirestore.instance.collection('Appointments');

      await appointmentsCollection.add({
        'id': appointment.id,
        'subject': appointment.subject,
        'description': appointment.description,
        'date': appointment.date,
        'startTime': appointment.startTime,
        'appointmentLength': appointment.appointmentLength,
        'location': appointment.location,
        'notes': appointment.notes,
        'status': appointment.status,
      });

      print('Appointment added successfully.');
    } catch (error) {
      print('Error adding appointment: $error');
      _showAlertDialog('Error', 'Error adding appointment: $error');
    }
  }

  void _showAlertDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
