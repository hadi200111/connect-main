import 'package:CampusConnect/Calendar/Appointments.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppointmentDetailsPage extends StatefulWidget {
  final Appointments appointment;

  const AppointmentDetailsPage({Key? key, required this.appointment}) : super(key: key);

  @override
  _AppointmentDetailsPageState createState() => _AppointmentDetailsPageState();
}

class _AppointmentDetailsPageState extends State<AppointmentDetailsPage> {
  bool _reminder = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Appointment Details',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView( // Added SingleChildScrollView
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Author:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.deepPurple),
              ),
              Text(widget.appointment.id, style: TextStyle(fontSize: 16)),
              SizedBox(height: 10),
              Text(
                'Subject:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.deepPurple),
              ),
              Text(widget.appointment.subject, style: TextStyle(fontSize: 16)),
              SizedBox(height: 10),
              Text(
                'Description:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.deepPurple),
              ),
              Text(widget.appointment.description, style: TextStyle(fontSize: 16)),
              SizedBox(height: 10),
              Text(
                'Date:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.deepPurple),
              ),
              Text(DateFormat('dd-MM-yyyy').format(widget.appointment.date), style: TextStyle(fontSize: 16)),
              SizedBox(height: 10),
              Text(
                'Start Time:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.deepPurple),
              ),
              Text(DateFormat('hh:mm').format(widget.appointment.startTime), style: TextStyle(fontSize: 16)), // Fixed the time format
              SizedBox(height: 10),
              Text(
                'Appointment Length:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.deepPurple),
              ),
              Text('${widget.appointment.appointmentLength} minutes', style: TextStyle(fontSize: 16)), // Changed hours to minutes
              SizedBox(height: 10),
              Text(
                'Location:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.deepPurple),
              ),
              Text(widget.appointment.location, style: TextStyle(fontSize: 16)),
              SizedBox(height: 10),
              if (widget.appointment.notes != null) ...[
                Text(
                  'Notes:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.deepPurple),
                ),
                Text(widget.appointment.notes!, style: TextStyle(fontSize: 16)),
                SizedBox(height: 10),
              ],
              Text(
                'Status:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.deepPurple),
              ),
              Text(widget.appointment.status, style: TextStyle(fontSize: 16)),
              SizedBox(height: 20),
              Row(
                children: [
                  Checkbox(
                    value: _reminder,
                    onChanged: (value) {
                      setState(() {
                        _reminder = value!;
                      });
                    },
                  ),
                  Text(
                    'Set Reminder',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.deepPurple),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
