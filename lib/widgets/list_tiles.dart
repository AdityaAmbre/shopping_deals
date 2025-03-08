import 'package:flutter/material.dart';

class ListTiles {
  /// List Tiles - Icon Before
  static ListTile listTiesIconBefore(
      {required Widget icon,
        required String name,
        VoidCallback? onTapCallback}) {
    return ListTile(
      onTap: onTapCallback,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          icon,
          const SizedBox(width: 10),
          Expanded(child: Text(name, overflow: TextOverflow.ellipsis, /*style: const TextStyle(color: Colors.white70)*/)),
        ],
      ),
      dense: false,
    );
  }

  /// List Tiles - Icon After
  static ListTile listTilesIconAfter(
      {required Widget icon,
        required String name,
        VoidCallback? onTapCallback}) {
    return ListTile(
      onTap: onTapCallback,
      title: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(child: Text(name, overflow: TextOverflow.ellipsis, style: const TextStyle(color: Colors.white70))),
            const SizedBox(width: 10),
            icon,
          ],
        ),
      ),
      dense: true,
    );
  }
}