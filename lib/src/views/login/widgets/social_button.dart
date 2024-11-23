import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/material.dart';

class SocialButton extends HookWidget {
  const SocialButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.label,
  });

  final String icon;
  final void Function()? onPressed;
  final String? label;

  @override
  Widget build(BuildContext context) {
    final AnimationController controller = useAnimationController(
      duration: const Duration(milliseconds: 150),
    );

    final Animation<double> scaleAnimation = useMemoized(
      () => Tween<double>(begin: 1.0, end: 0.95).animate(
        CurvedAnimation(parent: controller, curve: Curves.easeInOut),
      ),
      <Object?>[controller],
    );

    return GestureDetector(
      onTapDown: (_) => controller.forward(),
      onTapUp: (_) => controller.reverse(),
      onTapCancel: () => controller.reverse(),
      onTap: onPressed,
      child: AnimatedBuilder(
        animation: scaleAnimation,
        builder: (BuildContext context, Widget? child) => Transform.scale(
          scale: scaleAnimation.value,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Colors.grey[200]!,
              ),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(
                  width: 24,
                  height: 24,
                  child: Image.asset(
                    icon,
                    fit: BoxFit.contain,
                  ),
                ),
                if (label != null) ...<Widget>[
                  const SizedBox(width: 12),
                  Text(
                    label!,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[800],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
