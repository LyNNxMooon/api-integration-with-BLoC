import 'package:bloc_api/BLoC/cart/cart_events.dart';
import 'package:bloc_api/BLoC/cart/cart_states.dart';
import 'package:bloc_api/domain/cart_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartBloc extends Bloc<CartEvents, CartStates> {
  final CartRepo cartRepo;

  CartBloc({required this.cartRepo}) : super(CartInitial()) {
    on<GetCart>(_onGetCart);
    on<UpdateCart>(_onUpdateCart);
    on<RemoveCart>(_onRemoveCart);
    on<ClearCart>(_onClearCart);
    on<AddToCart>(_onAddToCart);
  }

  Future<void> _onGetCart(GetCart event, Emitter<CartStates> emit) async {
    emit(CartLoading());

    try {
      final cartResponse = await cartRepo
          .getUserCart("164|uNpuRnfvFB2cBfrqAym3hJdbzoydjTa5ZeX50bhf");

      emit(CartLoaded(cartResponse));
    } catch (error) {
      emit(CartErrors(error.toString()));
    }
  }

  Future<void> _onUpdateCart(UpdateCart event, Emitter<CartStates> emit) async {
    emit(CartLoading());

    try {
      final cartUpdateResponse = await cartRepo.updateCart(
          "164|uNpuRnfvFB2cBfrqAym3hJdbzoydjTa5ZeX50bhf",
          event.cartID,
          event.qty);

      final cartFetchResponse = await cartRepo
          .getUserCart("164|uNpuRnfvFB2cBfrqAym3hJdbzoydjTa5ZeX50bhf");
      emit(CartUpdated(cartUpdateResponse));
      emit(CartLoaded(cartFetchResponse));
    } catch (error) {
      emit(CartErrors(error.toString()));
    }
  }

  Future<void> _onRemoveCart(RemoveCart event, Emitter<CartStates> emit) async {
    emit(CartLoading());

    try {
      final cartRemovedResponse = await cartRepo.removeCart(
        "164|uNpuRnfvFB2cBfrqAym3hJdbzoydjTa5ZeX50bhf",
        event.cartID,
      );

      final cartFetchResponse = await cartRepo
          .getUserCart("164|uNpuRnfvFB2cBfrqAym3hJdbzoydjTa5ZeX50bhf");
      emit(CartRemoved(cartRemovedResponse));
      emit(CartLoaded(cartFetchResponse));
    } catch (error) {
      emit(CartErrors(error.toString()));
    }
  }

  Future<void> _onClearCart(ClearCart event, Emitter<CartStates> emit) async {
    emit(CartLoading());

    try {
      final cartClearedResponse = await cartRepo.clearCart(
        "164|uNpuRnfvFB2cBfrqAym3hJdbzoydjTa5ZeX50bhf",
      );

      final cartFetchResponse = await cartRepo
          .getUserCart("164|uNpuRnfvFB2cBfrqAym3hJdbzoydjTa5ZeX50bhf");
      emit(CartRemoved(cartClearedResponse));
      emit(CartLoaded(cartFetchResponse));
    } catch (error) {
      emit(CartErrors(error.toString()));
    }
  }

  Future _onAddToCart(AddToCart event, Emitter<CartStates> emit) async {
    emit(CartLoading());

    try {
      final cartAddedResponse = await cartRepo.addToCart(
          "164|uNpuRnfvFB2cBfrqAym3hJdbzoydjTa5ZeX50bhf",
          event.productID,
          event.qty);

      final cartFetchResponse = await cartRepo
          .getUserCart("164|uNpuRnfvFB2cBfrqAym3hJdbzoydjTa5ZeX50bhf");
      emit(CartAdded(cartAddedResponse));
      emit(CartLoaded(cartFetchResponse));
    } catch (error) {
      emit(CartErrors(error.toString()));
    }
  }
}
