abstract class CartEvents {}

class GetCart extends CartEvents {}

class UpdateCart extends CartEvents {
  int cartID;
  int qty;

  UpdateCart({required this.cartID, required this.qty});
}

class RemoveCart extends CartEvents {
  int cartID;

  RemoveCart({required this.cartID});
}

class ClearCart extends CartEvents {}

class AddToCart extends CartEvents {
  int productID;
  int qty;

  AddToCart({required this.productID, required this.qty});
}
