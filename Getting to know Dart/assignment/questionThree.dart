void main() {
  print(emailValidate('adsf@gmail.com'));
  print(phoneNumberValidate('09781043781'));
}

bool emailValidate(String email) {
  if (email.contains('@gmail.com')) {
    if (email.endsWith('@gmail.com') || !email.startsWith('@gmail.com')) {
      return true;
    }
  }

  return false;
}

bool phoneNumberValidate(String phone) {
  var result = false;

  if (phone.length >= 10) {
    result = phone.startsWith('+959');

    if (phone.startsWith('09')) {
      result = phone.replaceRange(0, 1, '+959').length >= 10;
    }
  }

  return result;
}
