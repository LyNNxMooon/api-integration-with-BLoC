import 'package:bloc_api/BLoC/cart/cart_events.dart';
import 'package:bloc_api/BLoC/cart/cart_states.dart';
import 'package:bloc_api/data/models/hive_model.dart';
import 'package:bloc_api/domain/cart_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartBloc extends Bloc<CartEvents, CartStates> {
  final CartRepo cartRepo;

  CartBloc({required this.cartRepo}) : super(CartInitial()) {
    on<GetCart>(_onGetCart);
    on<UpdateCart>(_onUpdateCart);
    on<RemoveCart>(_onRemoveCart);

    on<AddToCart>(_onAddToCart);
  }

    final _hiveModel = HiveModel();

  Future<void> _onGetCart(GetCart event, Emitter<CartStates> emit) async {
    emit(CartLoading());

    try {
      final cartResponse = await cartRepo
          .getUserCart(_hiveModel.getUserToken());

      emit(CartLoaded(cartResponse));
    } catch (error) {
      emit(CartErrors(error.toString()));
    }
  }

  Future<void> _onUpdateCart(UpdateCart event, Emitter<CartStates> emit) async {
    emit(CartLoading());

    try {
      final cartUpdateResponse = await cartRepo.updateCart(
          _hiveModel.getUserToken(),
          event.cartID,
          event.qty);

      final cartFetchResponse = await cartRepo
          .getUserCart(_hiveModel.getUserToken());
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
        _hiveModel.getUserToken(),
        event.cartID,
      );

      final cartFetchResponse = await cartRepo
          .getUserCart(_hiveModel.getUserToken());
      emit(CartRemoved(cartRemovedResponse));
      emit(CartLoaded(cartFetchResponse));
    } catch (error) {
      emit(CartErrors(error.toString()));
    }
  }



  Future _onAddToCart(AddToCart event, Emitter<CartStates> emit) async {
    emit(CartLoading());

    try {
      final cartAddedResponse = await cartRepo.addToCart(
          _hiveModel.getUserToken(),
          event.productID,
          event.qty);

      final cartFetchResponse = await cartRepo
          .getUserCart(_hiveModel.getUserToken());
      emit(CartAdded(cartAddedResponse));
      emit(CartLoaded(cartFetchResponse));
    } catch (error) {
      emit(CartErrors(error.toString()));
    }
  }
}
