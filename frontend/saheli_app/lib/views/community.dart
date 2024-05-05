import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:math';

class CommunitySection extends StatefulWidget {
  @override
  _CommunitySectionState createState() => _CommunitySectionState();
}

class _CommunitySectionState extends State<CommunitySection> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Women Community'),
        backgroundColor: Theme.of(context).colorScheme.secondary,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('posts').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No posts available.'));
          }
          return ListView.builder(
            itemCount: snapshot.data?.docs.length,
            itemBuilder: (BuildContext context, int index) {
              var post = snapshot.data?.docs[index];
              if (post == null || post.data() == null) {
                return SizedBox(); // Skip if post data is null
              }
              return PostCard(
                post: post,
                onUpdate: () {
                  // This empty function will force the widget to rebuild when the data changes
                  setState(() {});
                },
                key: Key(post.id),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        onPressed: () {
          // Navigate to a screen where user can create a new post
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreatePostScreen()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class PostCard extends StatefulWidget {
  final QueryDocumentSnapshot post;
  final VoidCallback onUpdate;

  const PostCard({required Key key, required this.post, required this.onUpdate})
      : super(key: key);

  @override
  _PostCardState createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  late int upvotes;
  late int downvotes;
  late Color upvoteColor;
  late Color downvoteColor;

  @override
  void initState() {
    super.initState();
    upvotes = widget.post['upvotes'] ?? 0;
    downvotes = widget.post['downvotes'] ?? 0;
    upvoteColor = Colors.blue;
    downvoteColor = Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    var username = widget.post['username'] ?? '';
    var content = widget.post['content'] ?? '';
    var imageUrl = widget.post['imageUrl'];

    return Card(
      color: Theme.of(context).colorScheme.primary,
      elevation: 3,
      margin: EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (imageUrl != null)
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ListTile(
            title: Text(username, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 8),
                Text(content),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(Icons.thumb_up),
                      color: upvoteColor,
                      onPressed: () {
                        setState(() {
                          if (upvoteColor == Colors.blue) {
                            upvotes++;
                            setState(() {
                              upvoteColor = Colors.green;
                            });

                            if (downvoteColor == Colors.green) {
                              downvotes--;
                              downvoteColor = Colors.red;
                            }
                          } else {
                            upvotes--;
                            upvoteColor = Colors.blue;
                          }
                        });
                        FirebaseFirestore.instance
                            .collection('posts')
                            .doc(widget.post.id)
                            .update(
                                {'upvotes': upvotes, 'downvotes': downvotes});
                        widget.onUpdate(); // Update UI
                      },
                    ),
                    Text('$upvotes Upvotes'),
                    IconButton(
                      icon: Icon(Icons.thumb_down),
                      color: downvoteColor,
                      onPressed: () {
                        setState(() {
                          if (downvoteColor == Colors.red) {
                            downvotes++;
                            downvoteColor = Colors.green;
                            if (upvoteColor == Colors.green) {
                              upvotes--;
                              upvoteColor = Colors.blue;
                            }
                          } else {
                            downvotes--;
                            downvoteColor = Colors.red;
                          }
                        });
                        FirebaseFirestore.instance
                            .collection('posts')
                            .doc(widget.post.id)
                            .update(
                                {'upvotes': upvotes, 'downvotes': downvotes});
                        widget.onUpdate(); // Update UI
                      },
                    ),
                    Text('$downvotes Downvotes'),
                    IconButton(
                      icon: Icon(Icons.comment),
                      onPressed: () {
                        // Implement comment functionality
                        // This could navigate to a screen where users can view/add comments
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CreatePostScreen extends StatefulWidget {
  @override
  _CreatePostScreenState createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final TextEditingController _contentController = TextEditingController();
  File? _image; // Change to nullable File

  // Rest of the code remains the same
  Future getImage() async {
    final pickedFile =
        await ImagePicker().getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Post'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: getImage,
              child: Container(
                color: Colors.grey[200],
                height: 150,
                child: _image == null // Check if _image is null
                    ? Center(child: Icon(Icons.add_a_photo))
                    : Image.file(_image!,
                        fit: BoxFit
                            .cover), // Use _image! to access non-nullable value
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _contentController,
              decoration: InputDecoration(
                labelStyle:
                    TextStyle(color: Theme.of(context).colorScheme.primary),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.secondary),
                  // Change border color when focused
                ),
                labelText: "What's in your mind today?",
              ),
              maxLines: 5,
            ),
            SizedBox(height: 15),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    Theme.of(context)
                        .colorScheme
                        .primary), // Change background color
                minimumSize: MaterialStateProperty.all<Size>(
                    Size(double.infinity, 45)), // Change width
              ),
              onPressed: () async {
                showDialog(
                  context: context,
                  // barrierDismissible: false,
                  builder: (BuildContext context) {
                    return Center(
                      child: CircularProgressIndicator(), // Circular progress indicator
                    );
                  },
                );
                String randomUsername =
                    'SqueakyTomato' + Random().nextInt(1000).toString();
                // Upload image if available
                String? imageUrl; // Change to nullable String
                if (_image != null) {
                  final ref = FirebaseStorage.instance
                      .ref()
                      .child('images')
                      .child('${DateTime.now()}.jpg');
                  final TaskSnapshot snapshot = await ref.putFile(_image!);

                  final downloadUrl = await snapshot.ref.getDownloadURL();

                  // await ref.putFile(_image!);
                  // imageUrl = await ref.getDownloadURL();
                  // Add post to Firestore
                  await FirebaseFirestore.instance.collection('posts').add({
                    'username': randomUsername,
                    'content': _contentController.text,
                    'upvotes': 0,
                    'downvotes': 0,
                    'imageUrl': downloadUrl,
                  });
                }
                Navigator.pop(
                    context); // Navigate back to the community section
              },

              child: Text(
                'Post',
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
