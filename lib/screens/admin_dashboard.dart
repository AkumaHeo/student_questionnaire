import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

class AdminDashboard extends StatefulWidget {
  @override
  _AdminDashboardState createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  final TextEditingController _studentIdController = TextEditingController();
  final TextEditingController _studentNameController = TextEditingController();
  String? _selectedDepartment;

  
  List<String> departments = [
    'Computer Science',
    'Statistic',
    'Chemistry',
    'Biology',
    'Physics'
  ];

  Future<void> _addStudentToDatabase() async {
    final String studentId = _studentIdController.text.trim();
    final String studentName = _studentNameController.text.trim();
    final String? department = _selectedDepartment;

    if (studentId.isNotEmpty && studentName.isNotEmpty && department != null) {
      try {
        await FirebaseFirestore.instance
            .collection('students')
            .doc(studentId)
            .set({
          'id': studentId,
          'name': studentName,
          'department': department,
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Student added successfully!")),
        );

        _studentIdController.clear();
        _studentNameController.clear();
        setState(() {
          _selectedDepartment = null; 
        });
      } catch (e) {
        print("Error adding student: $e");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to add student. Please try again.")),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
                "Please enter both Student ID, Name, and select a Department.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Admin Dashboard"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _studentIdController,
              keyboardType: TextInputType.number,
              inputFormatters: [
                LengthLimitingTextInputFormatter(
                    14), 
                FilteringTextInputFormatter.digitsOnly, // Allow only digits
              ],
              decoration: InputDecoration(
                labelText: "Student ID",
                border: OutlineInputBorder(),
                errorText: _studentIdController.text.length != 14 &&
                        _studentIdController.text.isNotEmpty
                    ? "Student ID must be exactly 14 numbers."
                    : null,
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _studentNameController,
              decoration: InputDecoration(
                labelText: "Student Name",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: _selectedDepartment,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedDepartment = newValue;
                });
              },
              items: departments.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              decoration: InputDecoration(
                labelText: "Department",
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please select a department.';
                }
                return null;
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_studentIdController.text.length == 14) {
                  _addStudentToDatabase();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content:
                            Text("Student ID must be exactly 14 numbers.")),
                  );
                }
              },
              child: Text("Add Stvnudent", style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                textStyle: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
