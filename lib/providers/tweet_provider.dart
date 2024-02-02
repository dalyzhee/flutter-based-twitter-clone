import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_app/models/tweet.dart';
import 'package:twitter_app/providers/user_provider.dart';

final streamProvider = StreamProvider.autoDispose<List<Tweets>>((ref) {
  return FirebaseFirestore.instance
      .collection("tweets")
      .orderBy("postTime", descending: true)
      .snapshots()
      .map((event) {
    List<Tweets> tweets = [];

    for (var i = 0; i < event.docs.length; i++) {
      tweets.add(Tweets.fromMap(event.docs[i].data()));
    }

    return tweets;
  });
});

final tweetProvider = Provider<TwitterApi>((ref) {
  return TwitterApi(ref);
});

class TwitterApi {
  TwitterApi(this.ref);
  final Ref ref;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<void> postTweet(String tweet) async {
    LocalUser currentUser = ref.read(userProvider);
    await _firestore.collection("tweets").add(Tweets(
          uid: currentUser.id,
          profilePic: currentUser.user.profilePic,
          name: currentUser.user.name,
          content: tweet,
          postTime: Timestamp.now(),
        ).toMap());
  }
}
