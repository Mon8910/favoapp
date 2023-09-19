import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  const ImageInput({super.key,required this.onpicked});
  final void Function(File image) onpicked;
  @override
  State<ImageInput> createState() {
    return _ImageInputState();
  }
}

class _ImageInputState extends State<ImageInput> {
  File? selectedphoto;
  void _takephoto() async {
    final imagepicker = ImagePicker();
    final pickedimage =
        await imagepicker.pickImage(source: ImageSource.camera, maxWidth: 600);
    if (pickedimage == null) {
      return;
    }
    setState(() {
      selectedphoto = File(pickedimage.path);
    });
    widget.onpicked(selectedphoto!);
    
  }

  @override
  Widget build(BuildContext context) {
    Widget content = TextButton.icon(
        onPressed: _takephoto,
        icon: const Icon(Icons.camera),
        label: const Text('take image'));
    if (selectedphoto != null) {
      content = Image.file(
        selectedphoto!,
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
      );
    }

    return GestureDetector(
      onTap: _takephoto,
      child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Theme.of(context).colorScheme.primary.withOpacity(.2),
            ),
          ),
          height: 250,
          width: double.infinity,
          alignment: Alignment.center,
          child: content),
    );
  }
}
