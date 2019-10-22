//
//  LogDataRowView.swift
//  LizardLog
//
//  Created by Ben Gottlieb on 10/21/19.
//  Copyright © 2019 Stand Alone, Inc. All rights reserved.
//

import SwiftUI

struct LogDataRowView: View {
	@State var logData: LogData
	
	func label(_ string: String) -> some View {
		Text(string)
			.font(.caption)
			.foregroundColor(.secondary)
	}
	
	var body: some View {
		VStack() {
			Button(action: {
				//select date
			}) {
				Text(logData.dateString)
			}
			HStack() {
				self.label("Fed")
				TextField("Food", text: self.logData.foodBinding)
			}
			HStack() {
				Toggle(isOn: self.logData.waterBinding) { self.label("Watered") }
				Toggle(isOn: self.logData.bathBinding) { self.label("Bathed") }
				Toggle(isOn: self.logData.outputBinding) { self.label("Pooped") }
			}
		}
		.padding(.horizontal, 3)
	}
}

struct LogDataRowView_Previews: PreviewProvider {
	static var previews: some View {
		LogDataRowView(logData: DummyLogData())
	}
}
