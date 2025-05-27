import 'package:dresscode/src/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class SelectableGarmentCard extends StatefulWidget {
  const SelectableGarmentCard({
    required this.imageUrl,
    this.initiallySelected = false,
    this.onSelectionChanged,
    super.key,
  });

  final String imageUrl;
  final bool initiallySelected;
  final Function(bool selected)? onSelectionChanged;

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
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isSelected ? AppColors.secondaryColor : AppColors.disabledColor,
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 6,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: CachedNetworkImage(
              imageUrl: widget.imageUrl,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
              placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
        ),
        Positioned(
          top: 8,
          right: 8,
          child: InkWell(
            onTap: toggleSelection,
            borderRadius: BorderRadius.circular(20),
            child: CircleAvatar(
              backgroundColor: isSelected ? AppColors.secondaryColor : AppColors.primaryColor,
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
