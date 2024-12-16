abstract class CartEvents {}

class GetCart extends CartEvents {}

class UpdateCart extends CartEvents {
  int cartID;
  int qty;

  UpdateCart({required this.cartID, required this.qty});
}
