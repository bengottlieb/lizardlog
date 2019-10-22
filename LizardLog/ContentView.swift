//
//  ContentView.swift
//  LizardLog
//
//  Created by Ben Gottlieb on 10/21/19.
//  Copyright © 2019 Stand Alone, Inc. All rights reserved.
//

import SwiftUI

extension LogDataRecord: LogData, Identifiable {
	func save() {
		try? self.managedObjectContext?.save()
	}

	var ID: String { return self.objectID.uriRepresentation().absoluteString }
}

struct ContentView: View {
	@FetchRequest(
		entity: LogDataRecord.entity(),
		sortDescriptors: [ NSSortDescriptor(keyPath: \LogDataRecord.date, ascending: false)]
	) var logs: FetchedResults<LogDataRecord>
	
	@Environment(\.managedObjectContext) var managedObjectContext

	func deleteRecord(at indexes: IndexSet) {
		for index in indexes {
			managedObjectContext.delete(self.logs[index])
		}
	}

    var body: some View {
		NavigationView() {
			List {
				ForEach(logs) { log in
					LogDataRowView(logData: log)
				}
				.onDelete(perform: deleteRecord)
			}
			.navigationBarTitle("Lizard Log")
			.navigationBarItems(trailing: Button(action: {
				DataStore.instance.addLog()
			}, label: {
				Image(systemName: "plus.circle.fill")
			}))
		}
	}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
