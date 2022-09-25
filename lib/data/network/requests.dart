// دا الي هيشيل الداتا الي رايحه app_api request
class LoginRequests {
  String email;
  String password;
  LoginRequests(this.email, this.password);
}

class RegisterRequest {
  String userName;
  String countryMobileCode;
  String mobileNumber;
  String email;
  String password;
  String profilePicture;
  RegisterRequest(
    this.userName,
    this.countryMobileCode,
    this.mobileNumber,
    this.email,
    this.password,
    this.profilePicture,
  );
}
