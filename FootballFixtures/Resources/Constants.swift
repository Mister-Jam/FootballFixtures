//
//  Constants.swift
//  FootballFixtures
//
//  Created by King Bileygr on 8/24/21.
//

import UIKit

struct Constants {
    static let titleText    = [NSAttributedString.Key.foregroundColor: UIColor.black,
                              .font: UIFont.systemFont(ofSize: 25, weight: .semibold)]
    static let smallTitle   = [NSAttributedString.Key.foregroundColor: UIColor.black,
                              .font: UIFont.systemFont(ofSize: 18, weight: .semibold)]
    
    enum Titles {
        static let table    = "Table"
        static let fixture  = "Fixtures"
        static let teams    = "Teams"
    }
    
    enum Images {
        static let ball     = "soccer"
        static let field    = "soccer-field"
        static let soccer   = UIImage(named: Images.ball)
    }
    
    enum URLConstants {
        static let baseURL      = "https://api.football-data.org/"
        static let apiToken     = "9f067c76c3f14177a8392b663aef600e"
        static let httpHeader   = "X-Auth-Token"
    }
    
    enum URLPaths {
        static let allFixtures      = "v2/matches"
        static let allCompetitions  = "v2/competitions/"
        static let standings        = "/standings/"
        static let matches          = "/matches"
        static let teams            = "v2/teams/"
        static let matchFilterQuery = Constants.generateMatchesFilterQuery()
    }
    
    
    static func formatText(firstText: String, secondText: String?,
                    firstColor: UIColor, secondColor: UIColor,
                    firstFont: UIFont, secondFont: UIFont) -> NSMutableAttributedString {
        
        let firstTextAttributes: [NSAttributedString.Key : NSObject]    = [.font : firstFont, .foregroundColor : firstColor]
        let secondTextAttributes: [NSAttributedString.Key : NSObject]   = [.font : secondFont, .foregroundColor : secondColor]
        let attributedText      = NSMutableAttributedString(string: firstText, attributes: firstTextAttributes)
        if let secondText       = secondText {
            attributedText.append(NSAttributedString(string: secondText, attributes: secondTextAttributes))
        }
        let paragraphStyle       = NSMutableParagraphStyle()
        paragraphStyle.alignment = .left
        
        let length = attributedText.string.count
        attributedText.addAttribute(.paragraphStyle, value: paragraphStyle, range: _NSRange(location: 0, length: length))
        return attributedText
    }
    
    static func generateMatchesFilterQuery() -> String {
        let todaysDate      = Date()
        let calendar        = Calendar.current
        let nextWeekendDate = calendar.nextWeekend(startingAfter: todaysDate)?.end
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat    = "yyyy-MM-dd"
        guard let nextWeekDate      = nextWeekendDate else { return "" }
        let todaysDateString        = dateFormatter.string(from: todaysDate)
        let nextWeekendDateString   = dateFormatter.string(from: nextWeekDate)
        let query                   = "?dateFrom=\(todaysDateString)&dateTo=\(nextWeekendDateString)"
        
        return query
    }
    
    static func failureAlert(title: String = "Woops!", viewController: UIViewController, text: String,
                             completion: ((UIAlertAction) -> Void)? = nil) {

        let controller      = UIAlertController(title: title, message: text, preferredStyle: .alert)
        let alert           = UIAlertAction(title: "Dismiss", style: .cancel, handler: completion)
        controller.addAction(alert)
        viewController.present(controller, animated: true, completion: nil)

    }
    
    static func topMostController() -> UIViewController {
        var topController: UIViewController = (UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.rootViewController!)!
            while topController.presentedViewController != nil {
                topController = topController.presentedViewController!
            }
            return topController
        }
}
