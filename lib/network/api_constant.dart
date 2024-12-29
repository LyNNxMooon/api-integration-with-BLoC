//Base URl
const kBaseURL = "https://oneoneshop.hapeyeapp.com/api/v1";
const kBaseURL1 = "https://easy-buy.ecommyanmar.com/api";

//End Points
const kEndPointForRegister = "/register";
const kEndPointForGetCurrentUser = "/customer";
const kEndPointForLogout = "/logout";
const kEndPointForLogin = "/login";
const kEndPointForProducts = "/products";
const kEndPointForGetCart = "/cart";
const kEndPointForUpdateCart = "/cart/{$kPathParamKeyForCartID}";
const kEndPointForClearCart = "/cart/clear";
const kEndPointForRemoveCart = "/cart/delete/{$kPathParamKeyForCartID}";
const kEndPointForAddToCart = "/cart";
const kEndPointForBanners = "/banners";
const kEndPointForProductDetails = "/products/{$kPathParamKeyForProductID}";
const kEndPointForGetProductImages =
    "/products/{$kPathParamKeyForProductID}/images";

//keys
const kAuthorizationKey = "Authorization";
const kParamKeyForEmailOrPhone = "emailOrPhone";
const kParamKeyForPassword = "password";
const kParamKeyForConfirmPassword = "password_confirmation";
const kParamKeyForName = "name";
const kParamKeyForPhone = "phone";
const kParamKeyForFcm = "fcm_token_key";
const kQueryParamKeyForPage = "page";
const kQueryParamKeyForLimit = "limit";
const kPathParamKeyForCartID = "CartID";
const kParamKeyForQuantity = "quantity";
const kParamKeyForProductID = "product_id";
const kPathParamKeyForProductID = "productID";
