//
//  GeneralExtension.swift
//  AuthenticationMVVMDemo
//
//  Created by Dhaval.Sabhaya on 06/07/22.
//

import Foundation

// MARK:- String extension
extension String {
    
    func toDate(_ formate: String = "yyyy-MM-dd") -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = formate
        return formatter.date(from: self)
    }
    
    func contains(find: String) -> Bool {
        return self.range(of: find) != nil
    }
    
    func containsIgnoringCase(find: String) -> Bool {
        return self.range(of: find, options: .caseInsensitive) != nil
    }
    
    // formatting text for currency textField
    func currencyInputFormatting() -> String {
        var number: NSNumber!
        let formatter = NumberFormatter()
        formatter.numberStyle = .currencyAccounting
        formatter.currencySymbol = "$"
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        
        var amountWithPrefix = self
        
        // remove from String: "$", ".", ","
        let regex = try! NSRegularExpression(pattern: "[^0-9]", options: .caseInsensitive)
        amountWithPrefix = regex.stringByReplacingMatches(in: amountWithPrefix, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.count), withTemplate: "")
        
        let double = (amountWithPrefix as NSString).doubleValue
        number = NSNumber(value: (double / 100))
        
        // if first number is 0 or all numbers were deleted
        guard number != 0 as NSNumber else {
            return ""
        }
        
        return formatter.string(from: number)!
    }
    
    enum RegularExpressions: String {
        case phone = "^\\s*(?:\\+?(\\d{1,3}))?([-. (]*(\\d{3})[-. )]*)?((\\d{3})[-. ]*(\\d{2,4})(?:[-.x ]*(\\d+))?)\\s*$"
    }
    
    func isValid(regex: RegularExpressions) -> Bool {
        return isValid(regex: regex.rawValue)
    }
    
    func isValid(regex: String) -> Bool {
        let matches = range(of: regex, options: .regularExpression)
        return matches != nil
    }
    
    public func trimLeadingOrTrailingSpace() -> String? {
        return self.trimmingCharacters(in: CharacterSet.whitespaces)
    }
    
    public var local: String {
        return NSLocalizedString(self, comment: "")
    }
    
    public var clearString: String {
        let tempStr = self.components(separatedBy: .whitespacesAndNewlines).filter {!$0.isEmpty}.joined(separator: " ")
        let set = CharacterSet(charactersIn: "\\:()_!\n\"\"")
        let stripped = tempStr.components(separatedBy: set).joined()
        return stripped
    }
    
    // To validate AlphaNumeric string
    public var validateAlphaNumeric: Bool {
        let validCharacterSet = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLKMNOPQRSTUVWXYZ1234567890").inverted
        return self.rangeOfCharacter(from: validCharacterSet) == nil
    }
    
    public func toUSNumber() -> String {
        return self.replacingOccurrences(of: "(\\d{3})(\\d{3})(\\d+)", with: "$1-$2-$3", options: .regularExpression, range: nil)
    }
    
    public func utcDateStringToLocalTimeZoneString(fromDateFormat: String = "yyyy-MM-dd'T'HH:mm:ssZ", toDateFormat: String = "MM/dd/yyyy HH:mm") -> String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = fromDateFormat
        if let utcDate = dateformat.date(from: self) {
            dateformat.timeZone = TimeZone.current
            dateformat.dateFormat = toDateFormat
            let toDateString: String = dateformat.string(from: utcDate)
            return toDateString
        }
        return ""
    }
    
    public func utcDateStringToLocalTimeZoneDate(fromDateFormat: String = "yyyy-MM-dd'T'HH:mm:ssZ") -> Date {
        let dateformat = DateFormatter()
        dateformat.dateFormat = fromDateFormat
        if let utcDate = dateformat.date(from: self) {
            dateformat.timeZone = TimeZone.current
            dateformat.dateFormat = fromDateFormat
            let toDateString: String = dateformat.string(from: utcDate)
            if let localDate = dateformat.date(from: toDateString) {
                return localDate
            }
        }
        return Date()
    }
    
    public func localDateStringToUTCTimeZoneString(fromDateFormat: String = "yyyy-MM-dd'T'HH:mm:ssZ", toDateFormat: String = "MM/dd/yyyy HH:mm") -> String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = fromDateFormat
        if let localDate = dateformat.date(from: self) {
            //dateformat.timeZone = TimeZone(abbreviation: "UTC") //DateFormatter By Default it's in UTC
            dateformat.dateFormat = toDateFormat
            let toDateString: String = dateformat.string(from: localDate)
            return toDateString
        }
        return ""
    }
    
    var bool: Bool {
        switch self.lowercased() {
        case "true", "t", "yes", "y", "1":
            return true
        case "false", "f", "no", "n", "0":
            return false
        default:
            return false
        }
    }
    
    var isBackspace: Bool {
        let char = self.cString(using: String.Encoding.utf8)!
        return strcmp(char, "\\b") == -92
    }
}

class DataValidator {
    static let StreetNameMaxLength = 255
    static let UserNameMaxLength = 50
    static let UserFirstNameMaxLength = 25
    static let CompanyNameMaxLength = 50
    static let StateMaxLength = 2
    static let ZipCodeMaxLength = 6
    static let ZipCodeMinLength = 5
    static let PhoneNumberMaxLength = 10
    static let PhoneNumberMaxLengthUSFormat = 15
    static let WaterHeaterName = 20
    static let SerialNumberMaxLength = 10
    static let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
    
    class func checkEmailValid(_ email: String) -> Bool {
        if email.isEmpty {
            return false
        } else {
            let isValidEmail = DataValidator.isValidFieldEmail(email: email)
            return isValidEmail
        }
    }
    
    class func validPassword(password: String) -> Bool {
        let passwordRegex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[d$@$!%*?&#])[A-Za-z\\dd$@$!%*?&#]{8,128}"
        return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: password)
    }
    
    class func validPhoneNumber(phoneNumber: String) -> Bool {
        let phoneRegex = "^\\d{10}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        return phoneTest.evaluate(with: phoneNumber)
    }
    
    class func validStateCode(stateCode: String) -> Bool {
        if stateCode.count == 2 {
            return true
        }
        return false
    }
    
    class func validateZipcode(zipCode: String) -> Bool {
        if zipCode.count >= 5 {
            return true
        }
        return false
    }
    
    class func validateStringForMaxLength(name: String, maxLength: Int = 50, replacementString: String = "") -> Bool {
        if replacementString.isBackspace {
            return true
        }
        return (name.count <= maxLength)
    }
    
    class func validateStringForAlphabeticValue(name: String, shouldAllowSpace: Bool = false, maxLength: Int = 50, replacementString: String = "") -> Bool {
        if replacementString.isBackspace {
            return true
        }
        var regex = "^[a-zA-Z]*$"
        if (shouldAllowSpace) {
            regex = "^[a-zA-Z ]*$"
        }
        let nameTest = NSPredicate(format: "SELF MATCHES %@", regex)
        return ((nameTest.evaluate(with: name)) && name.count <= maxLength)
    }
    
    class func validateStringForAlphanumericValue(name: String, shouldAllowSpace: Bool = false, maxLength: Int = 50, replacementString: String = "") -> Bool {
        if replacementString.isBackspace {
            return true
        }
        var regex = "^[a-zA-Z0-9]*$"
        if (shouldAllowSpace) {
            regex = "^[a-zA-Z0-9 ]*$"
        }
        let nameTest = NSPredicate(format: "SELF MATCHES %@", regex)
        return ((nameTest.evaluate(with: name)) && name.count <= maxLength)
    }
    
    class func validateStringForSpecificSpecialCharactersAlphanumericValue(name: String, maxLength: Int = 50, replacementString: String = "") -> Bool {
        if replacementString.isBackspace {
            return true
        }
        let regex = "^[a-zA-Z0-9!\"“”=\\<?#$%&’'‘()*+,-.:;<=>?@\\\\_/ ]*$"//\" /' //’
        let nameTest = NSPredicate(format: "SELF MATCHES %@", regex)
        return ((nameTest.evaluate(with: name)) && name.count <= maxLength)
    }
    
    class func isValidFieldEmail(email: String) -> Bool {
        let isValidFieldEmail = NSPredicate(format: "SELF MATCHES %@", DataValidator.emailRegex).evaluate(with: email)
        return isValidFieldEmail
    }
    
}
