//Base URl
const kBaseURL = "https://oneoneshop.hapeyeapp.com/api/v1";

//End Points
const kEndPointForRegister = "/register";
const kEndPointForGetCurrentUser = "/customer";
const kEndPointForLogout = "/logout";
const kEndPointForLogin = "/login";
const kEndPointForProducts = "/products";
const kEndPointForGetCart = "/cart";
const kEndPointForUpdateCart = "/cart/update/{$kPathParamKeyForCartID}";
const kEndPointForRemoveCart = "/cart/remove/{$kPathParamKeyForCartID}";
const kEndPointForAddToCart = "/cart/add";
const kEndPointForBanners = "/banners";
const kEndPointForProductDetails = "/products/{$kPathParamKeyForProductID}";
const kEndPointForGetProductImages =
    "/products/{$kPathParamKeyForProductID}/images";
const kEndPointForGenres = "/genres";

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
const kParamKeyForStatus = "status";
