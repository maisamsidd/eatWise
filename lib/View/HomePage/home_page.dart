import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eat_wise/Utils/Apis_utils.dart';
import 'package:eat_wise/Utils/app_colors.dart';
import 'package:eat_wise/View/Authentication/login_page.dart';
import 'package:eat_wise/View/Ai_related_work/ScanPage/scan_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    final ageController = TextEditingController();
    final diseaseController = TextEditingController();

    void showAddUserDialog(BuildContext context) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Add a Profile"),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      labelText: "Full Name",
                      hintText: "John Doe",
                    ),
                  ),
                  TextField(
                    controller: ageController,
                    decoration: const InputDecoration(
                      labelText: "Condition",
                      hintText: "e.g., Diabetes",
                    ),
                  ),
                  TextField(
                    controller: diseaseController,
                    decoration: const InputDecoration(
                      labelText: "Age",
                      hintText: "24",
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Get.back();
                },
                child: const Text("Cancel"),
              ),
              ElevatedButton(
                onPressed: () {
                  if (nameController.text.isNotEmpty &&
                      ageController.text.isNotEmpty &&
                      diseaseController.text.isNotEmpty) {
                    ApisUtils.users
                        .doc(ApisUtils.auth.currentUser!.uid.toString())
                        .collection("userDetails")
                        .add({
                      "name": nameController.text,
                      "age": ageController.text,
                      "disease": diseaseController.text,
                    });

                    nameController.clear();
                    ageController.clear();
                    diseaseController.clear();
                    Get.back();
                  } else {
                    Get.snackbar(
                      "Error",
                      "All fields are required",
                      snackPosition: SnackPosition.BOTTOM,
                    );
                  }
                },
                child: const Text("Add"),
              ),
            ],
          );
        },
      );
    }

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 144, 207, 236),
      // floatingActionButton: FloatingActionButton(
      //   child: const Icon(Icons.add),
      //   onPressed: () {

      //   },
      // ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              ApisUtils.auth.signOut().then((value) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              });
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: ApisUtils.users
            .doc(ApisUtils.auth.currentUser!.uid)
            .collection("userDetails")
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text("Error fetching data"));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("No user history available"));
          }

          final documents = snapshot.data!.docs;

          return ListView.builder(
            itemCount: documents.length,
            itemBuilder: (context, index) {
              final docData = documents[index].data() as Map<String, dynamic>;
              final docId = documents[index].id;

              return Dismissible(
                key: Key(docId),
                background: Container(
                  color: Colors.red,
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(left: 20.0),
                  child: const Icon(Icons.delete, color: Colors.white),
                ),
                secondaryBackground: Container(
                  color: Colors.blue,
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 20.0),
                  child: const Icon(Icons.arrow_forward, color: Colors.white),
                ),
                onDismissed: (direction) {
                  if (direction == DismissDirection.startToEnd) {
                    // Swipe right to delete
                    ApisUtils.users
                        .doc(ApisUtils.auth.currentUser!.uid)
                        .collection("userDetails")
                        .doc(docId)
                        .delete();
                    Get.snackbar(
                      "Deleted",
                      "${docData['name']} has been removed",
                      snackPosition: SnackPosition.BOTTOM,
                    );
                  } else if (direction == DismissDirection.endToStart) {
                    Get.to(() => const ScanPage())!.then((_) {
                      // Refresh the data when coming back
                      setState(() {});
                    });
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Material(
                    borderRadius: BorderRadius.circular(15),
                    elevation: 5,
                    child: Container(
                      width: double.infinity,
                      height: 100,
                      decoration: BoxDecoration(
                        color: MyColors.greyColor,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Name: ${docData['name'] ?? "No Name"}",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            Text(
                                "Condition: ${docData['age'] ?? "No Condition"}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18)),
                            Text("Age: ${docData['disease'] ?? "No Age"}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Container(
              width: 350,
              height: 50,
              decoration: BoxDecoration(
                  color: MyColors.whiteColor,
                  borderRadius: BorderRadius.circular(50)),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Center(
                      child: InkWell(
                        onTap: () {
                          showAddUserDialog(context);
                        },
                        child: const Icon(
                          Icons.notification_add,
                          size: 30,
                        ),
                      ),
                    ),
                    Center(
                      child: InkWell(
                        onTap: () {
                          showAddUserDialog(context);
                        },
                        child: const Icon(
                          Icons.add_outlined,
                          size: 30,
                        ),
                      ),
                    ),
                    Center(
                      child: InkWell(
                        onTap: () {},
                        child: const Icon(
                          Icons.menu,
                          size: 30,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
