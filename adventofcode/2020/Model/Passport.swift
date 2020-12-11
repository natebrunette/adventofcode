import ValidatedPropertyKit

extension Validation where Value == String {
  static var height: Validation {
    .init { value in
      guard let height = Int(value.prefix(value.count - 2)) else {
        return .failure("\(value) is not a valid height")
      }

      switch value.suffix(2) {
      case "cm":
        if height < 150 || height > 193 {
          return .failure("Height must be between 150 and 193 cm")
        }
      case "in":
        if height < 59 || height > 76 {
          return .failure("Height must be between 59 and 76 in")
        }
      default:
        return .failure("\(value) does not contain valid units")
      }

      return .success(())
    }
  }
}

struct Passport {
  @Validated(.greaterOrEqual(1920) && .lessOrEqual(2002))
  var birthYear: Int?

  @Validated(.greaterOrEqual(2010) && .lessOrEqual(2020))
  var issueYear: Int?

  @Validated(.greaterOrEqual(2020) && .lessOrEqual(2030))
  var expirationYear: Int?

  @Validated(.height)
  var height: String?

  @Validated(.regularExpression("^#[0-9a-f]{6}$"))
  var hairColor: String?

  @Validated(.regularExpression("^(amb|blu|brn|gry|grn|hzl|oth)$"))
  var eyeColor: String?

  @Validated(.regularExpression("^[0-9]{9}$"))
  var passportId: String?

  var countryId: String?

  func isValid() -> Bool {
    _birthYear.isValid
      && _issueYear.isValid
      && _expirationYear.isValid
      && _height.isValid
      && _hairColor.isValid
      && _eyeColor.isValid
      && _passportId.isValid
  }
}
