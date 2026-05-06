import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:laptop_harbor_app/components/custom_text_field.dart';
import 'package:laptop_harbor_app/utils/utils.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  TextEditingController title = TextEditingController();
  TextEditingController imageURL = TextEditingController();
  final _db = FirebaseFirestore.instance.collection('categories');

  bool isloading = false;

  Future addCategory(context) async {
    setState(() {
      isloading = true;
    });
    try {
      final key = DateTime.now().millisecondsSinceEpoch;
      print(key);
      await _db.doc(key.toString()).set({
        "name": title.text,
        "imageURL": imageURL.text,
        "categoryid": key,
      });
      title.text = '';
      imageURL.text = '';
      Navigator.pop(context);
    } catch (e) {
      Utils.showMessage(context, e.toString());
    } finally {
      setState(() {
        isloading = false;
      });
    }
  }

  Future delete(id) async {
    try {
      // print(id);
      await _db.doc(id.toString()).delete();
    } catch (e) {
      Utils.showMessage(context, e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Category')),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('categories').snapshots(),

        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          final categoryData = snapshot.data!.docs;
          print(categoryData);

          return ListView.builder(
            itemCount: categoryData.length,
            itemBuilder: (context, index) {
              final data = categoryData[index].data();
              return ListTile(
                title: Text(data['name']),
                trailing: IconButton(
                  onPressed: () {
                    delete(data['categoryid']);
                  },
                  icon: Icon(Icons.delete, color: Colors.red),
                ),
              );
            },
          );
        },
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Add Categroy'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomTextField(controller: title, label: 'title'),
                  CustomTextField(controller: imageURL, label: 'imageURL'),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('cancel'),
                ),
                isloading
                    ? CircularProgressIndicator()
                    : TextButton(
                        onPressed: () {
                          addCategory(context);
                        },
                        child: Text('add'),
                      ),
              ],
            ),
          );
        },
        icon: Icon(Icons.add),
        label: Text('Add Category'),
      ),
    );
  }
}
