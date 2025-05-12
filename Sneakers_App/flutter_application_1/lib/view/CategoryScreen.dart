import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/model/ShoeModel.dart';
import 'package:flutter_application_1/view/ShoeDescription.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoryScreen extends StatelessWidget {
  final List<String> collectionNames;

  CategoryScreen({
    Key? key,
    required this.collectionNames,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Shoes",
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
      ),
      body: FutureBuilder<List<QuerySnapshot>>(
          future: Future.wait(
            collectionNames.map(
              (collection) =>
                  FirebaseFirestore.instance.collection(collection).get(),
            ),
          ),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No data available'));
            }
            final combinedData = snapshot.data!
                .expand((querySnapshot) => querySnapshot.docs)
                .toList();

            return ListView.builder(
              itemCount: combinedData.length,
              itemBuilder: (context, index) {
                final item = combinedData[index].data() as Map<String, dynamic>;
                return GestureDetector(
                  onTap: () {
                    Shoe shoe = Shoe(
                      name: item['name'],
                      imagePath: item['imageUrl'],
                      price: item['price'],
                      description: item['description'],
                      size: '',
                    );

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Shoedescription(shoe: shoe),
                      ),
                    );
                  },
                  child: Card(
                   shadowColor: Colors.black.withOpacity(1.0),
                    margin:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Image on the left
                          item['imageUrl'] != null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Image.network(
                                    item['imageUrl'],
                                    width: 135,
                                    height: 135,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : const Icon(
                                  Icons.no_photography_rounded,
                                  size: 100,
                                ),

                          const SizedBox(
                              width: 16), // Space between image and text

                          // Name and price on the right
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item['name'] ?? 'Unnamed Item',
                                  style: GoogleFonts.poppins(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  "MRP ₹${item['price'] ?? '0.00'}",
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Color.fromARGB(244, 56, 53, 53),
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
              },
            );
          }),
    );

    // return const Center(child: Text("Something went wrong."));
}
}