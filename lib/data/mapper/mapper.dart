import 'package:flutter_advanced/app/constants.dart';
import 'package:flutter_advanced/data/response/responses.dart';
import 'package:flutter_advanced/domain/model/model.dart';
import 'package:flutter_advanced/app/extensions.dart';

// transform response data came from API{JSON} to nonNullable data for storting into model
extension CustomerResponseMapper on CustomerResponse? {
  Customer toDomain() {
    return Customer(
      this?.id.orEmpty() ?? Constants.empty,
      this?.name.orEmpty() ?? Constants.empty,
      this?.numOfNotifications.orZero() ?? Constants.zero,
    );
  }

// ?? "" => this 3shan lo f2dy
// orEmpty()\orZero() var 3shan lo f2dy
}

extension ContactsResponseMapper on ContactsResponse? {
  Contacts toDomain() {
    return Contacts(
      this?.email.orEmpty() ?? Constants.empty,
      this?.phone.orEmpty() ?? Constants.empty,
      this?.link.orEmpty() ?? Constants.empty,
    );
  }

// ?? "" => this 3shan lo f2dy
// orEmpty()\orZero() var 3shan lo f2dy
}

extension AuthenticationResponseMapper on AuthenticationResponse? {
  Authentication toDomain() {
    return Authentication(
      this?.contacts.toDomain(),
      this?.customer.toDomain(),
    );
  }

// ?? "" => this 3shan lo f2dy
// orEmpty()\orZero() var 3shan lo f2dy
}

extension ForgotPasswordResponseMapper on ForgotPasswordResponse? {
  String toDomain() {
    return this?.support?.orEmpty() ?? Constants.empty;
  }

// ?? "" => this 3shan lo f2dy
// orEmpty()\orZero() var 3shan lo f2dy
}

extension ServiceResponseMapper on ServiceResponse? {
  Service toDomain() {
    return Service(
      this?.id.orZero() ?? Constants.zero,
      this?.title.orEmpty() ?? Constants.empty,
      this?.image.orEmpty() ?? Constants.empty,
    );
  }
}

extension StoreResponseMapper on StoreResponse? {
  Store toDomain() {
    return Store(
      this?.id.orZero() ?? Constants.zero,
      this?.title.orEmpty() ?? Constants.empty,
      this?.image.orEmpty() ?? Constants.empty,
    );
  }
}

extension BannersResponseMapper on BannersResponse? {
  BannerAd toDomain() {
    return BannerAd(
      this?.id.orZero() ?? Constants.zero,
      this?.link.orEmpty() ?? Constants.empty,
      this?.title.orEmpty() ?? Constants.empty,
      this?.image.orEmpty() ?? Constants.empty,
    );
  }
}

extension HomeResponseMapper on HomeResponse? {
  HomeObject toDomain() {
    // check if the list is empty
    List<Service> services =
        (this?.data?.services?.map((serviceResponse) => serviceResponse.toDomain()) ??
                const Iterable.empty())
            .cast<Service>()
            .toList();

    List<BannerAd> banners =
        (this?.data?.banners?.map((bannersResponse) => bannersResponse.toDomain()) ??
                const Iterable.empty())
            .cast<BannerAd>()
            .toList();

    List<Store> stores = (this?.data?.stores?.map((storesResponse) => storesResponse.toDomain()) ??
            const Iterable.empty())
        .cast<Store>()
        .toList();

    var data = HomeData(services, banners, stores);
    return HomeObject(data);
  }
}

extension StoreDetailsResponseMapper on StoreDetailsResponse? {
  StoreDetails toDomain() {
    return StoreDetails(
        this?.id?.orZero() ?? Constants.zero,
        this?.title?.orEmpty() ?? Constants.empty,
        this?.image?.orEmpty() ?? Constants.empty,
        this?.details?.orEmpty() ?? Constants.empty,
        this?.services?.orEmpty() ?? Constants.empty,
        this?.about?.orEmpty() ?? Constants.empty);
  }
}
