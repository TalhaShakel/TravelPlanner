import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SpecialityPage extends StatelessWidget {
  Future<List<QueryDocumentSnapshot>> getSpecialties() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('specialties').get();
    return querySnapshot.docs;
  }

  const SpecialityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<QueryDocumentSnapshot>>(
      future: getSpecialties(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Color(0xFF6FBDC6),
            ),
            backgroundColor: Color(0xFF6FBDC6),
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Color(0xFF6FBDC6),
            ),
            backgroundColor: Color(0xFF6FBDC6),
            body: Center(
              child: Text('Error: ${snapshot.error}'),
            ),
          );
        }

        var specialties = snapshot.data;

        return MaterialApp(
          home: Scaffold(
            appBar: AppBar(
              backgroundColor: Color(0xFF6FBDC6),
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(
                      context); // Navigate back to the previous screen
                },
              ),
            ),
            backgroundColor: Color(0xFF6FBDC6),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: Text(
                    'All Specialties',
                  ),
                ),
                SizedBox(height: 20),
                // Displaying specialties in a list
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: specialties?.length,
                    itemBuilder: (context, index) {
                      Map specialtyData = specialties![index].data() as Map;
                      return Card(
                        margin:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        child: Column(
                          children: [
                            ListTile(
                              title: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '${specialtyData['specialtyName']}',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.arrow_forward),
                                    onPressed: () {
                                      // Navigator.push(
                                      //   context,
                                      // MaterialPageRoute(
                                      //   builder: (context) => DoctorPage(
                                      //     specialtyID:
                                      //         specialtyData['specialtyID'],
                                      //     specialtyName:
                                      //         specialtyData['specialtyName'],
                                      //   ),
                                      // ),
                                      // );
                                      // Navigate to another page here
                                      // You can use Navigator.push to navigate to the desired page
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }
}
