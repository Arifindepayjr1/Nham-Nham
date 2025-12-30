# Models Folder

This folder contains all the data models for the Nham Nham food delivery application. These models represent the core entities and business logic of the app.

## Models Overview

### 🍔 Food & Menu Models

#### `AddOnOption`
Represents an individual add-on option that can be selected for a food item.

**Properties:**
- `id` - Unique identifier for the add-on option
- `name` - Display name of the add-on (e.g., "Extra Cheese")
- `price` - Additional cost for this add-on

**Example Usage:**
```dart
const extraCheese = AddOnOption(
  id: 'addon_001',
  name: 'Extra Cheese',
  price: 1.50,
);
```

---

#### `AddOnGroup`
Groups related add-on options together (e.g., "Toppings", "Extras").

**Properties:**
- `id` - Unique identifier for the add-on group
- `name` - Display name of the group
- `options` - List of available `AddOnOption` items

**Example Usage:**
```dart
const toppingsGroup = AddOnGroup(
  id: 'group_001',
  name: 'Toppings',
  options: [
    AddOnOption(id: 'addon_001', name: 'Extra Cheese', price: 1.50),
    AddOnOption(id: 'addon_002', name: 'Bacon', price: 2.00),
    AddOnOption(id: 'addon_003', name: 'Mushrooms', price: 1.00),
  ],
);
```

---

#### `SelectedAddOn`
Represents an add-on that has been selected by the user for their order.

**Properties:**
- `optionId` - Reference to the selected `AddOnOption` id
- `name` - Name of the selected add-on
- `price` - Price of the selected add-on

**Example Usage:**
```dart
const selectedCheese = SelectedAddOn(
  optionId: 'addon_001',
  name: 'Extra Cheese',
  price: 1.50,
);
```

---

#### `Category`
Represents a food category for organizing menu items.

**Properties:**
- `id` - Unique identifier for the category
- `name` - Display name (e.g., "Pizza", "Burgers")
- `iconUrl` - URL to the category icon image

**Example Usage:**
```dart
const pizzaCategory = Category(
  id: 'cat_001',
  name: 'Pizza',
  iconUrl: 'https://example.com/icons/pizza.png',
);
```

---

#### `Food`
Represents a food item available for order.

**Properties:**
- `id` - Unique identifier for the food item
- `name` - Name of the dish
- `description` - Detailed description
- `price` - Base price
- `imageUrl` - URL to the food image
- `restaurantId` - Reference to the restaurant offering this item
- `category` - Food category
- `addOnGroups` - Available add-on groups for customization

**Example Usage:**
```dart
const margheritaPizza = Food(
  id: 'food_001',
  name: 'Margherita Pizza',
  description: 'Classic pizza with tomato sauce, mozzarella, and fresh basil',
  price: 12.99,
  imageUrl: 'https://example.com/images/margherita.jpg',
  restaurantId: 'rest_001',
  category: Category(
    id: 'cat_001',
    name: 'Pizza',
    iconUrl: 'https://example.com/icons/pizza.png',
  ),
  addOnGroups: [
    AddOnGroup(
      id: 'group_001',
      name: 'Extra Toppings',
      options: [
        AddOnOption(id: 'addon_001', name: 'Extra Cheese', price: 1.50),
      ],
    ),
  ],
);
```

---

### 🛒 Cart Models

#### `CartItem`
Represents a single item in the user's shopping cart.

**Properties:**
- `foodId` - Reference to the `Food` item
- `price` - Price of the food item (base price)
- `quantity` - Number of items ordered
- `selectedAddOns` - List of selected add-ons for this item

**Example Usage:**
```dart
const cartItem = CartItem(
  foodId: 'food_001',
  price: 12.99,
  quantity: 2,
  selectedAddOns: [
    SelectedAddOn(
      optionId: 'addon_001',
      name: 'Extra Cheese',
      price: 1.50,
    ),
  ],
);

// Total cost calculation
final itemTotal = (cartItem.price + 
  cartItem.selectedAddOns.fold(0.0, (sum, addon) => sum + addon.price)) 
  * cartItem.quantity;
// Result: (12.99 + 1.50) * 2 = $28.98
```

---

#### `Cart`
Represents the user's shopping cart containing multiple items.

**Properties:**
- `userId` - Reference to the user who owns this cart
- `items` - List of `CartItem` objects

**Example Usage:**
```dart
const userCart = Cart(
  userId: 'user_001',
  items: [
    CartItem(
      foodId: 'food_001',
      price: 12.99,
      quantity: 2,
      selectedAddOns: [
        SelectedAddOn(optionId: 'addon_001', name: 'Extra Cheese', price: 1.50),
      ],
    ),
    CartItem(
      foodId: 'food_002',
      price: 8.99,
      quantity: 1,
      selectedAddOns: [],
    ),
  ],
);

// Calculate cart total
double calculateCartTotal(Cart cart) {
  return cart.items.fold(0.0, (total, item) {
    final addOnsTotal = item.selectedAddOns.fold(0.0, (sum, addon) => sum + addon.price);
    return total + ((item.price + addOnsTotal) * item.quantity);
  });
}
```

---

### 📦 Order Models

#### `OrderItem`
Represents a food item within an order (similar to `CartItem` but for completed orders).

**Properties:**
- `foodId` - Reference to the `Food` item
- `price` - Price at time of order
- `quantity` - Number of items ordered
- `selectedAddOns` - List of selected add-ons

**Example Usage:**
```dart
final orderItem = OrderItem(
  foodId: 'food_001',
  price: 12.99,
  quantity: 1,
  selectedAddOns: [
    SelectedAddOn(optionId: 'addon_001', name: 'Extra Cheese', price: 1.50),
  ],
);
```

---

#### `Order`
Represents a complete order from placement to delivery.

**Enums:**
- `OrderStatus`: pending, confirmed, preparing, onTheWay, delivered
- `PaymentMethod`: cash, creditCard

**Properties:**
- `id` - Unique order identifier
- `userId` - Reference to the customer
- `restaurantId` - Reference to the restaurant
- `items` - List of `OrderItem` objects
- `totalAmount` - Total order cost
- `status` - Current order status (mutable)
- `pickupLocation` - Restaurant location
- `dropOffLocation` - Delivery address
- `deliveryPersonId` - Reference to delivery driver (nullable)
- `createdAt` - Order timestamp
- `paymentMethod` - Payment method used

**Example Usage:**
```dart
final order = Order(
  id: 'order_001',
  userId: 'user_001',
  restaurantId: 'rest_001',
  items: [
    OrderItem(
      foodId: 'food_001',
      price: 12.99,
      quantity: 2,
      selectedAddOns: [],
    ),
  ],
  totalAmount: 25.98,
  status: OrderStatus.pending,
  pickupLocation: Location(
    latitude: 11.5564,
    longitude: 104.9282,
    address: '123 Restaurant St, Phnom Penh',
  ),
  dropOffLocation: Location(
    latitude: 11.5449,
    longitude: 104.8922,
    address: '456 Customer Ave, Phnom Penh',
  ),
  deliveryPersonId: null,
  createdAt: DateTime.now(),
  paymentMethod: PaymentMethod.creditCard,
);

// Update order status
order.status = OrderStatus.confirmed;
```

---

### 🏪 Restaurant Models

#### `Restaurant`
Represents a restaurant or food vendor.

**Properties:**
- `id` - Unique identifier
- `name` - Restaurant name
- `description` - Brief description
- `location` - Restaurant's physical location
- `categorys` - List of food categories offered
- `rating` - Average customer rating

**Example Usage:**
```dart
final restaurant = Restaurant(
  id: 'rest_001',
  name: 'Pizza Palace',
  description: 'Authentic Italian pizza made with fresh ingredients',
  location: Location(
    latitude: 11.5564,
    longitude: 104.9282,
    address: '123 Restaurant St, Phnom Penh',
  ),
  categorys: ['Pizza', 'Pasta', 'Desserts'],
  rating: 4.5,
);
```

---

### 🚚 Delivery Models

#### `DeliveryPerson`
Represents a delivery driver.

**Properties:**
- `id` - Unique identifier
- `name` - Driver's name
- `phoneNumber` - Contact number
- `currentLocation` - Real-time location

**Example Usage:**
```dart
const driver = DeliveryPerson(
  id: 'driver_001',
  name: 'John Doe',
  phoneNumber: '+855123456789',
  currentLocation: Location(
    latitude: 11.5500,
    longitude: 104.9200,
    address: 'On Route 123',
  ),
);
```

---

### 👤 User Models

#### `User`
Represents a customer in the app.

**Properties:**
- `id` - Unique user identifier
- `userName` - Display name
- `email` - Email address
- `password` - Encrypted password
- `phoneNumber` - Contact number
- `location` - Default delivery address

**Example Usage:**
```dart
const user = User(
  id: 'user_001',
  userName: 'Jane Smith',
  email: 'jane.smith@example.com',
  password: 'hashed_password_here',
  phoneNumber: '+855987654321',
  location: Location(
    latitude: 11.5449,
    longitude: 104.8922,
    address: '456 Customer Ave, Phnom Penh',
  ),
);
```

---

### 📍 Shared Models

#### `Location`
Represents geographical coordinates and addresses.

**Properties:**
- `latitude` - GPS latitude coordinate
- `longitude` - GPS longitude coordinate
- `address` - Human-readable address (optional)

**Example Usage:**
```dart
const location = Location(
  latitude: 11.5564,
  longitude: 104.9282,
  address: '123 Main Street, Phnom Penh, Cambodia',
);

// Location without address
const coordinates = Location(
  latitude: 11.5564,
  longitude: 104.9282,
);
```

---
