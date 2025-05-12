import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/view/customsnackbar.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key, required String email});
  @override
  _AdminScreenState createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController imageUrlController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  String? type;

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
//MEN SHOE
  Future<void> addShoeMen(
      String name, String price, String imagePath, String description) async {
    try {
      await firestore.collection('MenShoes').add({
        'name': name,
        'price': price,
        'imageUrl': imagePath,
        'description': description,
      });
      CustomSnackbar.showCustomSnackbar(
        message: "Shoe Added Successfully!",
        context: context,
        icon: Icons.check_circle,
      );
    } catch (e) {
      CustomSnackbar.showCustomSnackbar(
        message: "Failed to add shoe : $e",
        context: context,
        icon: Icons.dangerous_rounded,
      );
    }
  }

  Future<void> updateShoeMen(String id, String name, String price,
      String imagePath, String description) async {
    try {
      await firestore.collection('MenShoes').doc(id).update({
        'name': name,
        'price': price,
        'imageUrl': imagePath,
        'description': description,
      });
      CustomSnackbar.showCustomSnackbar(
        message: "Shoe Updated Successfully!",
        context: context,
        icon: Icons.check_circle,
      );
    } catch (e) {
      CustomSnackbar.showCustomSnackbar(
        message: "Failed to update shoe : $e",
        context: context,
        icon: Icons.dangerous_rounded,
      );
    }
  }

  Future<void> deleteShoeMen(String id) async {
    try {
      await firestore.collection('MenShoes').doc(id).delete();
      CustomSnackbar.showCustomSnackbar(
        message: "Shoe Deleted Successfully!",
        context: context,
        icon: Icons.check_circle,
      );
    } catch (e) {
      CustomSnackbar.showCustomSnackbar(
        message: "Failed to delete shoe : $e",
        context: context,
        icon: Icons.dangerous_rounded,
      );
    }
  }

  // WOMEN SHOE
  Future<void> addShoeWomen(
      String name, String price, String imagePath, String description) async {
    try {
      await firestore.collection('WomenShoes').add({
        'name': name,
        'price': price,
        'imageUrl': imagePath,
        'description': description,
      });
      CustomSnackbar.showCustomSnackbar(
        message: "Shoe Added Successfully!",
        context: context,
        icon: Icons.check_circle,
      );
    } catch (e) {
      CustomSnackbar.showCustomSnackbar(
        message: "Failed to add shoe : $e",
        context: context,
        icon: Icons.dangerous_rounded,
      );
    }
  }

  Future<void> updateShoeWomen(String id, String name, String price,
      String imagePath, String description) async {
    try {
      await firestore.collection('WomenShoes').doc(id).update({
        'name': name,
        'price': price,
        'imageUrl': imagePath,
        'description': description,
      });
      CustomSnackbar.showCustomSnackbar(
        message: "Shoe Updated Successfully!",
        context: context,
        icon: Icons.check_circle,
      );
    } catch (e) {
      CustomSnackbar.showCustomSnackbar(
        message: "Failed to update shoe : $e",
        context: context,
        icon: Icons.dangerous_rounded,
      );
    }
  }

  Future<void> deleteShoeWomen(String id) async {
    try {
      await firestore.collection('WomenShoes').doc(id).delete();
      CustomSnackbar.showCustomSnackbar(
        message: "Shoe Deleted Successfully!",
        context: context,
        icon: Icons.check_circle,
      );
    } catch (e) {
      CustomSnackbar.showCustomSnackbar(
        message: "Failed to delete shoe : $e",
        context: context,
        icon: Icons.dangerous_rounded,
      );
    }
  }

  //KIDS SHOE

  Future<void> addShoeKids(
      String name, String price, String imagePath, String description) async {
    try {
      await firestore.collection('KidsShoes').add({
        'name': name,
        'price': price,
        'imageUrl': imagePath,
        'description': description,
      });
      CustomSnackbar.showCustomSnackbar(
        message: "Shoe Added Successfully!",
        context: context,
        icon: Icons.check_circle,
      );
    } catch (e) {
      CustomSnackbar.showCustomSnackbar(
        message: "Failed to add shoe : $e",
        context: context,
        icon: Icons.dangerous_rounded,
      );
    }
  }

  Future<void> updateShoeKids(String id, String name, String price,
      String imagePath, String description) async {
    try {
      await firestore.collection('KidsShoes').doc(id).update({
        'name': name,
        'price': price,
        'imageUrl': imagePath,
        'description': description,
      });
      CustomSnackbar.showCustomSnackbar(
        message: "Shoe Updated Successfully!",
        context: context,
        icon: Icons.check_circle,
      );
    } catch (e) {
      CustomSnackbar.showCustomSnackbar(
        message: "Failed to update shoe : $e",
        context: context,
        icon: Icons.dangerous_rounded,
      );
    }
  }

  Future<void> deleteShoeKids(String id) async {
    try {
      await firestore.collection('KidsShoes').doc(id).delete();
      CustomSnackbar.showCustomSnackbar(
        message: "Shoe Deleted Successfully!",
        context: context,
        icon: Icons.check_circle,
      );
    } catch (e) {
      CustomSnackbar.showCustomSnackbar(
        message: "Failed to delete shoe : $e",
        context: context,
        icon: Icons.dangerous_rounded,
      );
    }
  }

  //SPORTS SHOES

  Future<void> addShoeSports(
      String name, String price, String imagePath, String description) async {
    try {
      await firestore.collection('SportsShoes').add({
        'name': name,
        'price': price,
        'imageUrl': imagePath,
        'description': description,
      });
      CustomSnackbar.showCustomSnackbar(
        message: "Shoe Added Successfully!",
        context: context,
        icon: Icons.check_circle,
      );
    } catch (e) {
      CustomSnackbar.showCustomSnackbar(
        message: "Failed to add shoe : $e",
        context: context,
        icon: Icons.dangerous_rounded,
      );
    }
  }

  Future<void> updateShoeSports(String id, String name, String price,
      String imagePath, String description) async {
    try {
      await firestore.collection('SportsShoes').doc(id).update({
        'name': name,
        'price': price,
        'imageUrl': imagePath,
        'description': description,
      });
      CustomSnackbar.showCustomSnackbar(
        message: "Shoe Updated Successfully!",
        context: context,
        icon: Icons.check_circle,
      );
    } catch (e) {
      CustomSnackbar.showCustomSnackbar(
        message: "Failed to update shoe : $e",
        context: context,
        icon: Icons.dangerous_rounded,
      );
    }
  }

  Future<void> deleteShoeSports(String id) async {
    try {
      await firestore.collection('SportsShoes').doc(id).delete();
      CustomSnackbar.showCustomSnackbar(
        message: "Shoe Deleted Successfully!",
        context: context,
        icon: Icons.check_circle,
      );
    } catch (e) {
      CustomSnackbar.showCustomSnackbar(
        message: "Failed to delete shoe : $e",
        context: context,
        icon: Icons.dangerous_rounded,
      );
    }
  }

  void showShoeDialog(
      {String? id,
      String? name,
      String? price,
      String? imagePath,
      String? description}) {
    if (id != null) {
      nameController.text = name ?? '';
      priceController.text = price?.toString() ?? '';
      imageUrlController.text = imagePath ?? '';
      descriptionController.text = description ?? '';
    } else {
      nameController.clear();
      priceController.clear();
      imageUrlController.clear();
      descriptionController.clear();
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(id == null ? 'Add Shoe' : 'Edit Shoe'),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Shoe Name'),
              ),
              TextField(
                controller: priceController,
                decoration: const InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: imageUrlController,
                decoration: const InputDecoration(labelText: 'Image URL'),
              ),
              TextField(
                controller: descriptionController,
                decoration:
                    const InputDecoration(labelText: 'Shoe Description'),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              final name = nameController.text.trim();
              final price = priceController.text.trim();
              final imagePath = imageUrlController.text.trim();
              final description = descriptionController.text.trim();

              if (type == 'menShoe') {
                if (id == null) {
                  addShoeMen(name, price, imagePath, description);
                } else {
                  updateShoeMen(id, name, price, imagePath, description);
                }
              } else if (type == 'womenShoe') {
                if (id == null) {
                  addShoeWomen(name, price, imagePath, description);
                } else {
                  updateShoeWomen(id, name, price, imagePath, description);
                }
              } else if (type == 'kidsShoe') {
                if (id == null) {
                  addShoeKids(name, price, imagePath, description);
                } else {
                  updateShoeKids(id, name, price, imagePath, description);
                }
              } else if (type == 'sportsShoe') {
                if (id == null) {
                  addShoeSports(name, price, imagePath, description);
                } else {
                  updateShoeSports(id, name, price, imagePath, description);
                }
              }

              Navigator.pop(context);
            },
            child: Text(id == null ? 'Add' : 'Update'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Admin - Shoe Inventory",
          style: GoogleFonts.raleway(
            fontWeight: FontWeight.w600,
            fontSize: 25,
            color: const Color.fromRGBO(255, 255, 255, 1),
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(13, 110, 253, 1),
        iconTheme: const IconThemeData(
          color: Color.fromRGBO(255, 255, 255, 1),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: GestureDetector(
              onTap: () {
                FirebaseAuth.instance.signOut(); // Handle logout
                Navigator.of(context).pop();
              },
              child: const Icon(
                Icons.logout,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  type = 'menShoe';
                  setState(() {});
                },
                child: Container(
                  height: 50,
                  width: 120,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(13, 110, 253, 1),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Center(
                    child: Text(
                      "Men",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                        color: const Color.fromRGBO(255, 255, 255, 1),
                      ),
                    ),
                  ),
                ),
              ),
              StreamBuilder<QuerySnapshot>(
                  stream: firestore.collection('MenShoes').snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return const Center(child: Text('No shoes available.'));
                    }

                    final menshoes = snapshot.data!.docs;

                    return Padding(
                      padding: const EdgeInsets.all(12),
                      child: Container(
                        height: 300,
                        child: ListView.builder(
                          itemCount: menshoes.length,
                          itemBuilder: (context, index) {
                            final shoe = menshoes[index];
                            final id = shoe.id;
                            final data = shoe.data() as Map<String, dynamic>;

                            return Card(
                              child: ListTile(
                                leading: Image.network(
                                  data['imageUrl'] ?? '',
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) =>
                                      const Icon(Icons.image),
                                ),
                                title: Text(data['name']),
                                subtitle: Text('Price: ${data['price']}'),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: const Icon(
                                        Icons.edit,
                                        color: Color.fromRGBO(13, 110, 253, 1),
                                      ),
                                      onPressed: () => showShoeDialog(
                                        id: id,
                                        name: data['name'],
                                        price: data['price'],
                                        imagePath: data['imageUrl'],
                                        description: data['description'],
                                      ),
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.delete,
                                          color: Colors.red),
                                      onPressed: () => deleteShoeMen(id),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  }),
              GestureDetector(
                onTap: () {
                  type = 'womenShoe';
                  setState(() {});
                },
                child: Container(
                  height: 50,
                  width: 120,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(13, 110, 253, 1),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Center(
                    child: Text(
                      "Women",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                        color: const Color.fromRGBO(255, 255, 255, 1),
                      ),
                    ),
                  ),
                ),
              ),
              StreamBuilder<QuerySnapshot>(
                  stream: firestore.collection('WomenShoes').snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return const Center(child: Text('No shoes available.'));
                    }

                    final womenshoes = snapshot.data!.docs;

                    return Padding(
                      padding: const EdgeInsets.all(12),
                      child: Container(
                        height: 300,
                        child: ListView.builder(
                          itemCount: womenshoes.length,
                          itemBuilder: (context, index) {
                            final shoe = womenshoes[index];
                            final id = shoe.id;
                            final data = shoe.data() as Map<String, dynamic>;

                            return Card(
                              child: ListTile(
                                leading: Image.network(
                                  data['imageUrl'] ?? '',
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) =>
                                      const Icon(Icons.image),
                                ),
                                title: Text(data['name']),
                                subtitle: Text('Price: ${data['price']}'),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: const Icon(
                                        Icons.edit,
                                        color: Color.fromRGBO(13, 110, 253, 1),
                                      ),
                                      onPressed: () => showShoeDialog(
                                        id: id,
                                        name: data['name'],
                                        price: data['price'],
                                        imagePath: data['imageUrl'],
                                        description: data['description'],
                                      ),
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.delete,
                                          color: Colors.red),
                                      onPressed: () => deleteShoeWomen(id),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  }),
              GestureDetector(
                onTap: () {
                  type = 'kidsShoe';
                  setState(() {});
                },
                child: Container(
                  height: 50,
                  width: 120,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(13, 110, 253, 1),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Center(
                    child: Text(
                      "Kids",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                        color: const Color.fromRGBO(255, 255, 255, 1),
                      ),
                    ),
                  ),
                ),
              ),
              StreamBuilder<QuerySnapshot>(
                  stream: firestore.collection('KidsShoes').snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return const Center(child: Text('No shoes available.'));
                    }

                    final kidsshoes = snapshot.data!.docs;

                    return Padding(
                      padding: const EdgeInsets.all(12),
                      child: Container(
                        height: 300,
                        child: ListView.builder(
                          itemCount: kidsshoes.length,
                          itemBuilder: (context, index) {
                            final shoe = kidsshoes[index];
                            final id = shoe.id;
                            final data = shoe.data() as Map<String, dynamic>;

                            return Card(
                              child: ListTile(
                                leading: Image.network(
                                  data['imageUrl'] ?? '',
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) =>
                                      const Icon(Icons.image),
                                ),
                                title: Text(data['name']),
                                subtitle: Text('Price: ${data['price']}'),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: const Icon(
                                        Icons.edit,
                                        color: Color.fromRGBO(13, 110, 253, 1),
                                      ),
                                      onPressed: () => showShoeDialog(
                                        id: id,
                                        name: data['name'],
                                        price: data['price'],
                                        imagePath: data['imageUrl'],
                                        description: data['description'],
                                      ),
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.delete,
                                          color: Colors.red),
                                      onPressed: () => deleteShoeKids(id),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  }),

              //Sports Shoes
              GestureDetector(
                onTap: () {
                  type = 'sportsShoe';
                  setState(() {});
                },
                child: Container(
                  height: 50,
                  width: 120,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(13, 110, 253, 1),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Center(
                    child: Text(
                      "Sports",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                        color: const Color.fromRGBO(255, 255, 255, 1),
                      ),
                    ),
                  ),
                ),
              ),
              StreamBuilder<QuerySnapshot>(
                  stream: firestore.collection('SportsShoes').snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return const Center(child: Text('No shoes available.'));
                    }

                    final sportshoes = snapshot.data!.docs;

                    return Padding(
                      padding: const EdgeInsets.all(12),
                      child: Container(
                        height: 300,
                        child: ListView.builder(
                          itemCount: sportshoes.length,
                          itemBuilder: (context, index) {
                            final shoe = sportshoes[index];
                            final id = shoe.id;
                            final data = shoe.data() as Map<String, dynamic>;

                            return Card(
                              child: ListTile(
                                leading: Image.network(
                                  data['imageUrl'] ?? '',
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) =>
                                      const Icon(Icons.image),
                                ),
                                title: Text(data['name']),
                                subtitle: Text('Price: ${data['price']}'),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: const Icon(
                                        Icons.edit,
                                        color: const Color.fromRGBO(
                                            13, 110, 253, 1),
                                      ),
                                      onPressed: () => showShoeDialog(
                                        id: id,
                                        name: data['name'],
                                        price: data['price'],
                                        imagePath: data['imageUrl'],
                                        description: data['description'],
                                      ),
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.delete,
                                          color: Colors.red),
                                      onPressed: () => deleteShoeSports(id),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  }),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showShoeDialog(),
        backgroundColor: const Color.fromRGBO(13, 110, 253, 1),
        child: const Icon(
          Icons.add,
          color: Color.fromRGBO(255, 255, 255, 1),
        ),
     ),
);
}
}