import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class SelectableGarmentCard extends StatefulWidget {
  final String imageUrl;
  final bool initiallySelected;
  final Function(bool selected)? onSelectionChanged;

  const SelectableGarmentCard({
    super.key,
    required this.imageUrl,
    this.initiallySelected = false,
    this.onSelectionChanged,
  });

  @override
  State<SelectableGarmentCard> createState() => _SelectableGarmentCardState();
}

class _SelectableGarmentCardState extends State<SelectableGarmentCard> {
  late bool isSelected;

  @override
  void initState() {
    super.initState();
    isSelected = widget.initiallySelected;
  }

  void toggleSelection() {
    setState(() {
      isSelected = !isSelected;
    });
    widget.onSelectionChanged?.call(isSelected);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Card(
          elevation: 3,
          child: CachedNetworkImage(
            imageUrl: widget.imageUrl,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        ),
        Positioned(
          top: 8,
          right: 8,
          child: InkWell(
            onTap: toggleSelection,
            borderRadius: BorderRadius.circular(20),
            child: CircleAvatar(
              backgroundColor: isSelected ? Colors.red : Colors.green,
              radius: 16,
              child: Icon(
                isSelected ? Icons.remove : Icons.add,
                color: Colors.white,
                size: 18,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
