import "package:flutter/material.dart";

class PreviousPageIcon extends StatelessWidget {
  final VoidCallback? goToHomePage;
  VoidCallback? triggerBack;
  VoidCallback? triggerSetState;
  PreviousPageIcon({
    this.triggerBack,
    this.goToHomePage,
    this.triggerSetState,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 2),
              spreadRadius: 1,
            ),
          ],
          shape: BoxShape.circle,
          color: Colors.white,
        ),
        child: IconButton(
          onPressed: () {
            if (Navigator.of(context).canPop()) {
              if (triggerBack == null) {
              } else {
                triggerBack!();
              }
              if (triggerSetState == null) {
              } else {
                triggerSetState!();
              }
              Navigator.of(context).pop();
            } else {
              goToHomePage!();
            }
          },
          icon: const Icon(Icons.close, size: 24, color: Colors.black),
        ),
      ),
    );
  }
}
