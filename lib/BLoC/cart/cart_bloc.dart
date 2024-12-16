import 'package:bloc_api/BLoC/cart/cart_events.dart';
import 'package:bloc_api/BLoC/cart/cart_states.dart';
import 'package:bloc_api/domain/cart_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartBloc extends Bloc<CartEvents, CartStates> {
  final CartRepo cartRepo;

  CartBloc({required this.cartRepo}) : super(CartInitial()) {
    on<GetCart>(_onGetCart);
    on<UpdateCart>(_onUpdateCart);
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

      emit(CartUpdated(cartUpdateResponse));

      final cartFetchResponse = await cartRepo
          .getUserCart("164|uNpuRnfvFB2cBfrqAym3hJdbzoydjTa5ZeX50bhf");

      emit(CartLoaded(cartFetchResponse));
    } catch (error) {
      emit(CartErrors(error.toString()));
    }
  }
}
