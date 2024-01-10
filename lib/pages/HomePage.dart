import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../components/drawer.dart';
import '../components/wall_post.dart';
import 'profile_page.dart';
import '../pages/chat_page.dart'; 

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.grey,
      ),
    );
  }
}


class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final User currentUser = FirebaseAuth.instance.currentUser!;
  final textController = TextEditingController();

  // keluar pengguna
  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  //navigate to ChatPage
  void goToChatPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChatPage(), // Ganti dengan halaman ChatPage yang sesuai
      ),
    );
  }

  //navigate to ProfilePage
  void goToProfilePage(BuildContext context) {
    //pop menu
    Navigator.pop(context);

    //go to profile
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProfilePage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Beranda'),
        backgroundColor: Colors.black, // Mengubah warna latar belakang AppBar menjadi hitam
      ),
      drawer: MyDrawer(
        onProfileTap: () => goToProfilePage(context),
        onSignOut: signUserOut,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // beranda
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("UserPosts")
                    .orderBy(
                      "TimeStamp",
                      descending: false,
                    )
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        final post = snapshot.data!.docs[index];
                        return WallPost(
                          message: post['Message'],
                          user: post['UserEmail'],
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),

            ElevatedButton(
              onPressed: () {
                goToChatPage(context); 
              },
              child: Image.asset(
                'lib/assets/button.png',
                width: 100, 
                height: 100, 
              ),
            ),
            const SizedBox(height: 50),
            // masuk sebagai
            Text(
              "Masuk sebagai: ${currentUser.email!}",
              style: const TextStyle(color: Colors.grey),
            ),

            const SizedBox(height: 50,)
          ],
        ),
      ),
    );
  }
}
