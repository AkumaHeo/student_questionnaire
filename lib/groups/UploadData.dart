import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:student_questionnaire/groups/AddStudentScreen.dart';

class GroupDetailsScreen extends StatefulWidget {
  final String groupId; 
  const GroupDetailsScreen({required this.groupId, super.key});

  @override
  _GroupDetailsScreenState createState() => _GroupDetailsScreenState();
}

class _GroupDetailsScreenState extends State<GroupDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.groupId), 
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Image.asset(
                'assets/${widget.groupId.toLowerCase().replaceAll("/", "_")}.png'), 
            SizedBox(height: 10),
            Text(
              "List of ${widget.groupId} students",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('students')
                  .where('group',
                      isEqualTo: widget.groupId) 
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text("Error: ${snapshot.error}"));
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                final students = snapshot.data?.docs ?? [];
                return Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: students.length,
                    itemBuilder: (context, index) {
                      final student =
                          students[index].data() as Map<String, dynamic>;
                      final studentId = student['id'];
                      final studentName = student['name'];
                      return StudentCard(
                        studentId: studentId,
                        studentName: studentName,
                        groupId: widget.groupId,
                        onEdit: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditStudentScreen(
                                studentId: studentId,
                                studentName: studentName,
                                groupId: widget.groupId,
                              ),
                            ),
                          );
                        },
                        onDelete: () async {
                          await FirebaseFirestore.instance
                              .collection('students')
                              .doc(studentId)
                              .delete();
                        },
                      );
                    },
                  ),
                );
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddStudentScreen(
                        groupId: widget.groupId), 
                  ),
                );
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.add, color: Colors.white),
                  SizedBox(width: 5),
                  Text("Add to the group",
                      style: TextStyle(color: Colors.white)),
                ],
              ),
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

class StudentCard extends StatelessWidget {
  final String studentId;
  final String studentName;
  final String groupId;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const StudentCard({
    required this.studentId,
    required this.studentName,
    required this.groupId,
    required this.onEdit,
    required this.onDelete,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: Icon(Icons.person),
        title: Text(studentName),
        subtitle: Text("ID: $studentId"),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: onEdit,
            ),
            IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: onDelete,
            ),
          ],
        ),
      ),
    );
  }
}

class EditStudentScreen extends StatefulWidget {
  final String studentId;
  final String studentName;
  final String groupId;

  const EditStudentScreen({
    required this.studentId,
    required this.studentName,
    required this.groupId,
    super.key,
  });

  @override
  _EditStudentScreenState createState() => _EditStudentScreenState();
}

class _EditStudentScreenState extends State<EditStudentScreen> {
  final TextEditingController _studentIdController = TextEditingController();
  final TextEditingController _studentNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _studentIdController.text = widget.studentId;
    _studentNameController.text = widget.studentName;
  }

  Future<void> _updateStudentInDatabase() async {
    final String newStudentId = _studentIdController.text.trim();
    final String newStudentName = _studentNameController.text.trim();

    if (newStudentId.isNotEmpty && newStudentName.isNotEmpty) {
      try {
        await FirebaseFirestore.instance
            .collection('students')
            .doc(widget.studentId)
            .update({
          'name': newStudentName,
        });

        if (newStudentId != widget.studentId) {
          await FirebaseFirestore.instance
              .collection('students')
              .doc(newStudentId)
              .set({
            'id': newStudentId,
            'name': newStudentName,
            'group': widget.groupId,
          });
          await FirebaseFirestore.instance
              .collection('students')
              .doc(widget.studentId)
              .delete();
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Student updated successfully!")),
        );
        Navigator.pop(context);
      } catch (e) {
        print("Error updating student: $e");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text("Failed to update student. Please try again.")),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please enter both Student ID and Name.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Student"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: _studentIdController,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              decoration: InputDecoration(
                labelText: "Student ID",
                border: OutlineInputBorder(),
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
            ElevatedButton(
              onPressed: () {
                _updateStudentInDatabase();
              },
              child:
                  Text("Update Student", style: TextStyle(color: Colors.white)),
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
