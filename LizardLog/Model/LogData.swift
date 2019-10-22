//
//  LogData.swift
//  LizardLog
//
//  Created by Ben Gottlieb on 10/21/19.
//  Copyright © 2019 Stand Alone, Inc. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

protocol LogData: class {
	var date: Date? { get set }
	var food: String? { get set }
	var water: Bool { get set }
	var output: Bool { get set }
	var bath: Bool { get set }
	
	var dateString: String { get }
	
	func save()
}

extension LogData {
	var dateString: String {
		guard let date = self.date else { return "" }
		let formatter = DateFormatter()
		formatter.dateStyle = .medium
		formatter.timeStyle = .short
		return formatter.string(from: date)
	}
	
	var dateBinding: Binding<Date> { Binding(get: { return self.date ?? Date() }, set: { self.date = $0; self.save() })}
	var foodBinding: Binding<String> { Binding(get: { return self.food ?? "" }, set: { self.food = $0; self.save() })}
	var waterBinding: Binding<Bool> { Binding(get: { return self.water }, set: { self.water = $0; self.save() })}
	var outputBinding: Binding<Bool> { Binding(get: { return self.output }, set: { self.output = $0; self.save() })}
	var bathBinding: Binding<Bool> { Binding(get: { return self.bath }, set: { self.bath = $0; self.save() })}
}


class DummyLogData: LogData, Identifiable {
	var date: Date? = Date()
	var food: String? = "Kale"
	var water = false
	var output = false
	var bath = false
 
	var ID: Date { return self.date ?? Date() }
	
	func save() {}
}
