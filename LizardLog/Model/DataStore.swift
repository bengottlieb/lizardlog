//
//  DataStore.swift
//  LizardLog
//
//  Created by Ben Gottlieb on 10/21/19.
//  Copyright © 2019 Stand Alone, Inc. All rights reserved.
//

import Foundation
import CoreData
import SwiftUI
import Combine

public class DataStore: NSObject {
	public static let instance = DataStore()

	let container: NSPersistentContainer
	public var mainContext: NSManagedObjectContext { return self.container.viewContext }
	
	public func setup() { }
	
	func addLog() {
		let log = LogDataRecord(context: self.mainContext)
		log.date = Date()
		
		try? self.mainContext.save()
	}
	
	public var lastRefreshed = Date()
		
	override init() {
		let modelURL = Bundle(for: DataStore.self).url(forResource: "LizardLog", withExtension: "momd")!
		let model = NSManagedObjectModel(contentsOf: modelURL)
		
		self.container = NSPersistentCloudKitContainer(name: "LizardLog", managedObjectModel: model!)

		let documents = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
		let cloudStore = NSPersistentStoreDescription(url: URL(fileURLWithPath: documents).appendingPathComponent("LizardLog-Data.sqlite"))
		
		cloudStore.cloudKitContainerOptions = NSPersistentCloudKitContainerOptions(containerIdentifier: "iCloud.com.standalone.lizardLog")
		container.persistentStoreDescriptions = [ cloudStore ]

		if let description = container.persistentStoreDescriptions.first {
			description.setOption(true as NSNumber, forKey: NSPersistentHistoryTrackingKey)
			description.setOption(true as NSNumber, forKey: NSPersistentStoreRemoteChangeNotificationPostOptionKey)
		}

		super.init()

		container.loadPersistentStores(completionHandler: { (storeDescription, error) in
			self.container.viewContext.automaticallyMergesChangesFromParent = true

			if let error = error as NSError? {
				fatalError("Unresolved error \(error), \(error.userInfo)")
			}
		})
	}
}
