import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:http/http.dart' as client;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:parish_aid_admin/core/api/api_base.dart';
import 'package:parish_aid_admin/core/loading_progress/loading_progress.dart';
import 'package:parish_aid_admin/core/resources/illustrations.dart';

import '../utils/enums.dart';

ImageProvider getImage(String path) {
  if (path.startsWith('http://') || path.startsWith('https://')) {
    return CachedNetworkImageProvider(path);
  } else if (path.contains('assets')) {
    //coming without image path
    return AssetImage(path);
  } else {
    return FileImage(File(path));
  }
}

Widget loadCircularImageWidget(String path, {BoxShape? shape, BoxFit? fit}) {
  return Container(
    clipBehavior: Clip.hardEdge,
    decoration: BoxDecoration(
      shape: shape ?? BoxShape.circle,
    ),
    child: path.isEmpty
        ? Image.asset(
      appLogoWhite,
      color: Colors.black26,
    )
        : getImageWidget(path, fit: fit),
  );
}

Widget loadImageWidget(String path, {BoxShape? shape, BoxFit? fit}) {
  return Container(
      //clipBehavior: Clip.hardEdge,
      //decoration: BoxDecoration(shape: shape ?? BoxShape.circle),
      child: path.isEmpty
          ? Image.asset(
              appLogoWhite,
              color: Colors.black26,
            )
          : getImageWidget(path, fit: fit));
}

Widget getImageWidget(String path, {BoxFit? fit}) {
  if (path != null) {
    if (path.startsWith('http://') || path.startsWith('https://')) {
      return CachedNetworkImage(
        imageUrl: path,
        placeholder: (context, url) => ProgressDialog.imageLoadingShimmer(),
        errorWidget: (context, url, error) => Center(
          child: CircleAvatar(
            backgroundColor: Colors.grey.shade300,
            backgroundImage: const AssetImage(appLogoWhite),
          ),
        ),
        fit: fit ?? BoxFit.cover,
      );
    } else if (path.contains('assets')) {
      return Image.asset(path, fit: BoxFit.cover);
    } else if (path.isEmpty) {
      return Center(
        child: CircleAvatar(
          backgroundColor: Colors.grey.shade300,
          backgroundImage: const AssetImage(appLogoWhite),
        ),
      );
    } else {
      return Image.file(
        File(path),
        fit: BoxFit.cover,
      );
    }
  } else {
    return Center(
      child: CircleAvatar(
        backgroundColor: Colors.grey.shade300,
        backgroundImage: const AssetImage(appLogoWhite),
      ),
    );
  }
}

String getImagePath(String path) {
  if (path.startsWith("http://") || path.startsWith('https://')) {
    return path;
  } else {
    return '$fileUrl$path';
  }
}

Future<String?> uploadImage(ImageSource source, {CropType? type}) async {
  final image = await ImagePicker().pickImage(source: source);

  if (image != null) {
    if (type != null) {
      return cropImage(image.path, type: type);
    } else {
      return image.path;
    }
  } else {
    return null;
  }
}

Future<String?> cropImage(String imagePath, {CropType? type}) async {
  //process Aspect Ratio options
  CropAspectRatio fixRatio() {
    switch (type) {
      case CropType.horiz:
        return const CropAspectRatio(ratioX: 4, ratioY: 3);
      case CropType.vertz:
        return const CropAspectRatio(ratioX: 3, ratioY: 4);
      case CropType.square:
        return const CropAspectRatio(ratioX: 1, ratioY: 1);
      default:
        return const CropAspectRatio(ratioX: 1, ratioY: 1);
    }
  }

  final image = await ImageCropper().cropImage(
      sourcePath: imagePath, aspectRatio: type != null ? fixRatio() : null);

  if (image != null) {
    return image.path;
  } else {
    return null;
  }
}

//Encode Network Image to Base64String
Future<String> imageToString(String imageUrl) async {
  const String patchUrl = 'https://wowcatholic.s3.amazonaws.com/';
  client.Response? response;

  if (imageUrl.startsWith('https://')) {
    response = await client.get(Uri.parse(patchUrl + imageUrl));
  }
  final base64 = base64Encode(response!.bodyBytes);
  return base64;
}

//Decode Image file encoded to Base64String to Image
Uint8List imageFromString(String base64String) {
  return base64Decode(base64String);
}
