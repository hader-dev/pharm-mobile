# Cart Functionality in `ecom_client_app`

This document provides an overview of the cart functionality implemented in the `ecom_client_app`. The cart feature allows users to manage their shopping cart, including adding, updating, and removing items, as well as calculating the total amount.

## Features

- **Add Items**: Users can add products to the cart.
- **Update Quantities**: Adjust the quantity of items in the cart dynamically.
- **Remove Items**: Remove individual items or clear the entire cart.
- **Checkout**: Provides a checkout option to proceed with the selected items.
- **Error Handling**: Gracefully handles errors during cart operations or data loading.

## Implementation Details

### 1. **CartCubit**
The `CartCubit` manages the state of the cart functionality. It handles:
- Adding items to the cart
- Updating item quantities
- Removing items
- Clearing the cart
- Calculating the total amount

#### Key Methods:
- `addCartItem(CartItem item)`: Adds a new item to the cart.
- `updateCartItemQuantity(int itemId, int quantity)`: Updates the quantity of a specific item.
- `removeCartItem(int itemId)`: Removes a specific item from the cart.
- `removeAll()`: Clears all items from the cart.

### 2. **Cart States**
The cart functionality uses the following states:
- `CartInitial`: Represents the initial state of the cart.
- `CartLoading`: Indicates that a cart operation is in progress.
- `CartLoadingSuccess`: Contains the updated cart data.
- `CartError`: Represents an error state with an appropriate message.

### 3. **UI Components**
#### **CartScreen**
- Displays the list of cart items.
- Provides options to update quantities, remove items, or clear the cart.
- Uses `BlocBuilder` to listen to state changes in `CartCubit`.

#### **CartItemWidget**
- Represents a single item in the cart.
- Includes item details, quantity controls, and a remove button.

#### **CartSummary**
- Displays the total amount of the cart.
- Provides a checkout button to proceed with the purchase.

### 4. **Cart Item Model**
The `CartItem` model represents the structure of a cart item. It includes properties like:
- `cart_item_id`: Unique identifier for the cart item.
- `quantity`: The quantity of the item in the cart.
- `note`: Optional notes for the item.
- `offset`: Additional metadata for the item.
- Associated `Article`: The product details.

### 5. **Checkout Bottom Sheet**
The checkout bottom sheet provides options to:
- Clear all items and proceed to checkout.
- Cancel the checkout process.

## How to Use

1. **Add Items to Cart**:
   - Use the `addCartItem` method in the `CartCubit` to add products to the cart.

2. **Update Quantities**:
   - Use the `updateCartItemQuantity` method to adjust the quantity of a specific item.

3. **Remove Items**:
   - Use the `removeCartItem` method to remove individual items.
   - Use the `removeAll` method to clear the entire cart.

4. **Checkout**:
   - Tap the "Clear all and checkout" button in the checkout bottom sheet to proceed.

## Error Handling

- If a cart operation fails, an error message is displayed using the `CartError` state.
- The app ensures a smooth user experience by handling edge cases gracefully.

## Future Enhancements

- **Cart Persistence**: Save the cart state locally or on the server for session continuity.
- **Discounts and Coupons**: Add support for applying discounts or coupons.
- **Wishlist Integration**: Allow users to move items between the cart and a wishlist.
- **Improved UI/UX**: Enhance the cart interface for better usability.

## Conclusion

The cart functionality in `ecom_client_app` is designed to provide a seamless and efficient shopping experience. It is built with scalability and flexibility in mind, making it easy to extend and enhance in the future.

For any questions or contributions, feel free to reach out!