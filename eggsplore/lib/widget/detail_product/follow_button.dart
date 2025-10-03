import 'package:flutter/material.dart';
import 'package:eggsplore/constants/colors.dart';

class FollowButton extends StatefulWidget {
  final bool isInitiallyFollowing;
  final VoidCallback? onFollow;
  final VoidCallback? onUnfollow;

  const FollowButton({
    super.key,
    this.isInitiallyFollowing = false,
    this.onFollow,
    this.onUnfollow,
  });

  @override
  State<FollowButton> createState() => _FollowButtonState();
}

class _FollowButtonState extends State<FollowButton> {
  late bool isFollowing;

  @override
  void initState() {
    super.initState();
    isFollowing = widget.isInitiallyFollowing;
  }

  void toggleFollow() {
    setState(() {
      isFollowing = !isFollowing;
    });

    if (isFollowing) {
      widget.onFollow?.call();
    } else {
      widget.onUnfollow?.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: isFollowing ? AppColors.grey[300] : AppColors.bleki,
      ),
      onPressed: toggleFollow,
      child: Text(
        isFollowing ? "Following" : "Follow",
        style: TextStyle(
          color: isFollowing ? AppColors.bleki : AppColors.white,
        ),
      ),
    );
  }
}
