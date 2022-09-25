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
