import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:twitter_app/providers/user_provider.dart';

class SettingPage extends ConsumerStatefulWidget {
  const SettingPage({super.key});

  @override
  ConsumerState<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends ConsumerState<SettingPage> {
  final TextEditingController nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    LocalUser currentUser = ref.watch(userProvider);
    nameController.text = currentUser.user.name;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: () async {
                final ImagePicker picker = ImagePicker();
                final XFile? image = await picker.pickImage(
                    source: ImageSource.gallery, requestFullMetadata: false);
                if (image != null) {
                  ref
                      .read(userProvider.notifier)
                      .updatePicture(File(image.path));
                }
              },
              child: CircleAvatar(
                radius: 100,
                foregroundImage: NetworkImage(currentUser.user.profilePic),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Center(
              child: Text("Tap Image to change"),
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: "Enter your name"),
              controller: nameController,
            ),
            TextButton(
              onPressed: () {
                ref.read(userProvider.notifier).updateName(nameController.text);
              },
              child: const Text("Update name"),
            )
          ],
        ),
      ),
    );
  }
}
