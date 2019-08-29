//
//  CoreDataProtocol.swift
//  theRush
//
//  Created by Minhaz Mohammad on 8/29/19.
//  Copyright © 2019 SMPL Inc. All rights reserved.
//

import CoreData
import Foundation
import RxSwift

protocol AbstractRepository {
    associatedtype T
    
    func query(with predicate: NSPredicate?, sortDescriptors: [NSSortDescriptor]?) -> Observable<[T]>
    
    func save(entity: T) -> Observable<Void>
    
    func delete(entity: T) -> Observable<Void>
}

protocol CoreDataRepresentable {
    associatedtype CoreDataType: Persistable
    
    var id: Int { get }
    
    func update(entity: CoreDataType)
    
    func sync(in context: NSManagedObjectContext) -> Observable<CoreDataType>
}

protocol ModelConvertibleType {
    associatedtype ModelType
    
    func asModel() -> ModelType
}

protocol Persistable: NSFetchRequestResult, ModelConvertibleType {
    static var entityName: String { get }
    
    static func fetchRequest() -> NSFetchRequest<Self>
}
