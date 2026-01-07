import 'package:flutter/material.dart';
import 'package:nham_nham/data/datasources/local/food_local.dart';
import 'package:nham_nham/data/repositories/food_repository.dart';
import 'package:nham_nham/models/cart_item.dart';
import 'package:nham_nham/models/food.dart';
import 'package:nham_nham/services/foods.service.dart';

class CartDisplayCard extends StatefulWidget {
  final VoidCallback increaseQuantity;
  final VoidCallback decreaseQuantity;
  final String foodId;
  final List<SelectedAddOn> selectedAddOn;
  final quantity;
  final totalPrice;

  const CartDisplayCard({
    super.key,
    required this.increaseQuantity,
    required this.decreaseQuantity,
    required this.foodId,
    required this.selectedAddOn,
    required this.quantity,
    required this.totalPrice,
  });

  @override
  State<CartDisplayCard> createState() => _CartDisplayCardState();
}

class _CartDisplayCardState extends State<CartDisplayCard> {
  Food? foodData;
  
  @override
  void initState() {
    super.initState();
    _initFood(widget.foodId);
  }

  @override
  Widget build(BuildContext context) {
    if (foodData == null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            "Food Id ${widget.foodId} Not Found",
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 14,
            ),
          ),
        ),
      );
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Container(
            height: 70,
            width: 70,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                foodData!.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 12),
          
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  foodData!.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                
                if (widget.selectedAddOn.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(
                    _getSelectAddOnToText(widget.selectedAddOn),
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.shade900,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
                
                const SizedBox(height: 12),
                

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: widget.decreaseQuantity,
                            icon: const Icon(Icons.remove),
                            iconSize: 18,
                            color: Colors.black87,
                            padding: const EdgeInsets.all(8),
                            constraints: const BoxConstraints(),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Text(
                              widget.quantity.toString(),
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: widget.increaseQuantity,
                            icon: const Icon(Icons.add),
                            iconSize: 18,
                            color: Colors.black87,
                            padding: const EdgeInsets.all(8),
                            constraints: const BoxConstraints(),
                          ),
                        ],
                      ),
                    ),
                    
                    
                    Text(
                      "\$${widget.totalPrice.toStringAsFixed(2)}",
                      style: TextStyle(
                        color: Colors.pink.shade700,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _initFood(String foodId) async {
    try {
      FoodLocalDatasources foodLocalDatasources = FoodLocalDatasources();
      FoodRepository foodRepository = FoodRepository(
        foodLocalDatasources: foodLocalDatasources,
      );
      FoodsService foodsService = FoodsService(foodRepository: foodRepository);
      Food data = await foodsService.getSpecificFoodById(foodId);
      setState(() {
        foodData = data;
      });
    } catch (error) {
      logger.e("Error When Trying to Find food Id : $foodId : $error");
    }
  }

  String _getSelectAddOnToText(List<SelectedAddOn> selectedAddOn) {
    List<String> selectedAddOnListName = selectedAddOn.map((el) {
      return el.name;
    }).toList();

    return selectedAddOnListName.join(" • ");
  }
}