import 'package:flutter/material.dart';

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
        backgroundColor: isFollowing ? Colors.grey[300] : Colors.black,
      ),
      onPressed: toggleFollow,
      child: Text(
        isFollowing ? "Following" : "Follow",
        style: TextStyle(
          color: isFollowing ? Colors.black : Colors.white,
        ),
      ),
    );
  }
}
