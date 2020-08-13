//
//  DateFormatter.swift
//  Utils
//
//  Created by Waut Wyffels on 09/08/2020.
//  Copyright © 2020 Quick Development. All rights reserved.
//

import Foundation

public extension DateFormatter {
	static let iso8601Full: DateFormatter = {
		let formatter = DateFormatter()
		formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
		formatter.calendar = Calendar(identifier: .iso8601)
		formatter.timeZone = TimeZone(secondsFromGMT: 0)
		formatter.locale = Locale(identifier: "en_US_POSIX")
		return formatter
	}()
}
