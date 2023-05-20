import 'dart:io';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:syberwaifu/constants/assets.dart';
import 'package:syberwaifu/functions/image.dart';

class ChatAvatar extends StatelessWidget {
  final String avatar;
  final double? size;
  final double? radius;
  const ChatAvatar({
    super.key,
    required this.avatar,
    this.size,
    this.radius,
  });

  const ChatAvatar.small({Key? key, required String avatar, double radius = 4})
      : this(key: key, avatar: avatar, size: 40, radius: radius);

  const ChatAvatar.middle(
      {Key? key, required String avatar, double radius = 10})
      : this(key: key, avatar: avatar, size: 100, radius: radius);

  const ChatAvatar.big({Key? key, required String avatar, radius = 15})
      : this(key: key, avatar: avatar, size: 150, radius: radius);

  const ChatAvatar.large({Key? key, required String avatar, radius = 24})
      : this(key: key, avatar: avatar, size: 240, radius: radius);

  @override
  Widget build(BuildContext context) {
    final avatarUri = getUri(avatar);
    if (isAssets(avatar)) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(radius ?? 0),
        child: ExtendedImage.asset(
          avatarUri,
          width: size,
          height: size,
          loadStateChanged: (state) {
            if (state.extendedImageLoadState == LoadState.failed) {
              return Container(
                width: size,
                height: size,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(radius ?? 0)),
                child: const Icon(Icons.face),
              );
            }
            return null;
          },
        ),
      );
    } else if (isFile(avatar)) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(radius ?? 0),
        child: ExtendedImage.file(
          File(avatarUri),
          width: size,
          height: size,
          loadStateChanged: _loadStateChanged,
          enableMemoryCache: false,
        ),
      );
    } else if (isNetwork(avatar)) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(radius ?? 0),
        child: ExtendedImage.network(
          avatarUri,
          width: size,
          height: size,
          loadStateChanged: _loadStateChanged,
        ),
      );
    }
    return Container(
      width: size,
      height: size,
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(radius ?? 0)),
      child: const Icon(Icons.face),
    );
  }

  Widget? _loadStateChanged(ExtendedImageState state) {
    if (state.extendedImageLoadState == LoadState.failed) {
      return ChatAvatar(
        avatar: AssetsConstants.defaultAIAvatar,
        size: size,
        radius: radius,
      );
    }
    return null;
  }
}
