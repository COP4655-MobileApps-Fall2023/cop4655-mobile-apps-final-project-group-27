//
//  User.swift
//  lab-insta-parse
//
//  Created by Charlie Hieger on 11/29/22.
//

import Foundation

// TODO: Pt 1 - Import Parse Swift
import ParseSwift

// TODO: Pt 1 - Create Parse User model
// https://github.com/parse-community/Parse-Swift/blob/3d4bb13acd7496a49b259e541928ad493219d363/ParseSwift.playground/Pages/3%20-%20User%20-%20Sign%20Up.xcplaygroundpage/Contents.swift#L16

struct User: ParseUser {
    // Required by ParseObject
    var objectId: String?
    var createdAt: Date?
    var updatedAt: Date?
    var ACL: ParseACL?
    var originalData: Data?

    // Required by ParseUser
    var username: String?
    var email: String?
    var emailVerified: Bool?
    var password: String?
    var authData: [String: [String: String]?]?

    // Personal details
    var profilename: String?
    var gender: String?
    var height: String?  // stored as "X'Y\""
    var currentWeight: Double?  // in pounds
    var goalWeight: Double?  // in pounds
    var age: Int?

    // Computed properties for BMI and daily caloric goal
    var bmi: Double? {
        guard let currentWeight = currentWeight, let height = height else { return nil }
        let heightInMeters = convertHeightToMeters(height)
        let weightInKilograms = convertPoundsToKilograms(currentWeight)
        return weightInKilograms / (heightInMeters * heightInMeters)
    }

    var dailyCaloricGoal: Double? {
        guard let currentWeight = currentWeight, let goalWeight = goalWeight, let gender = gender, let height = height, let age = age else { return nil }
        let heightInMeters = convertHeightToMeters(height)
        let weightInKilograms = convertPoundsToKilograms(currentWeight)
        let heightInCm = heightInMeters * 100
        let bmr = calculateBMR(gender: gender, weightInKg: weightInKilograms, heightInCm: heightInCm, age: age)
        let maintenanceCalories = bmr * 1.375  // Assuming a moderate activity level

        if goalWeight > currentWeight {
            return maintenanceCalories + 500
        } else {
            return maintenanceCalories - 500
        }
    }

    // Helper methods for calculations
    private func convertHeightToMeters(_ height: String) -> Double {
        let components = height.split(separator: "'").map { String($0) }
        let feet = Double(components[0]) ?? 0
        let inches = Double(components[1].replacingOccurrences(of: "\"", with: "")) ?? 0
        return (feet * 0.3048) + (inches * 0.0254)
    }

    private func convertPoundsToKilograms(_ pounds: Double) -> Double {
        return pounds * 0.453592
    }

    private func calculateBMR(gender: String, weightInKg: Double, heightInCm: Double, age: Int) -> Double {
        if gender == "Male" {
            let weightComponent = 13.397 * weightInKg
            let heightComponent = 4.799 * heightInCm
            let ageComponent = 5.677 * Double(age)
            return 88.362 + weightComponent + heightComponent - ageComponent
        } else {
            let weightComponent = 9.247 * weightInKg
            let heightComponent = 3.098 * heightInCm
            let ageComponent = 4.330 * Double(age)
            return 447.593 + weightComponent + heightComponent - ageComponent
        }
    }
}

    // TODO: Pt 2 - Add custom property for `lastPostedDate`
    var lastPostedDate: Date?


