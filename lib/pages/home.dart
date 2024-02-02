import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_app/models/tweet.dart';
import 'package:twitter_app/pages/settings.dart';
import 'package:twitter_app/pages/tweets.dart';
import 'package:twitter_app/providers/tweet_provider.dart';
import 'package:twitter_app/providers/user_provider.dart';

class Home extends ConsumerWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    LocalUser currentUser = ref.watch(userProvider);
    return Scaffold(
      appBar: AppBar(
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4.0),
          child: Container(
            color: Colors.grey,
            height: 1,
          ),
        ),
        title: const Image(
          image: AssetImage(
            "assets/twitter.png",
          ),
          width: 50,
        ),
        leading: Builder(builder: (context) {
          return GestureDetector(
            onTap: () => Scaffold.of(context).openDrawer(),
            child: CircleAvatar(
              foregroundImage: NetworkImage(currentUser.user.profilePic),
            ),
          );
        }),
      ),
      body: ref.watch(streamProvider).when(
          data: (List<Tweets> tweets) {
            return ListView.separated(
              separatorBuilder: (context, index) => const Divider(
                color: Colors.black,
              ),
              itemCount: tweets.length,
              itemBuilder: (context, count) {
                return ListTile(
                    leading: CircleAvatar(
                      foregroundImage: NetworkImage(tweets[count].profilePic),
                    ),
                    title: Text(
                      tweets[count].name,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      tweets[count].content,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ));
              },
            );
          },
          error: (error, stackTrace) => const Center(
                child: Text("Error"),
              ),
          loading: () => const CircularProgressIndicator()),
      drawer: Drawer(
          backgroundColor: Colors.white,
          child: Column(
            children: [
              Image.network(
                currentUser.user.profilePic,
                height: 300,
              ),
              ListTile(
                title: Text("Hello, ${currentUser.user.name}",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18)),
              ),
              ListTile(
                title: const Text("Settings"),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SettingPage()));
                },
              ),
              ListTile(
                title: const Text("Sign out"),
                onTap: () {
                  FirebaseAuth.instance.signOut();
                  ref.read(userProvider.notifier).logout();
                },
              )
            ],
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => const Tweet()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
