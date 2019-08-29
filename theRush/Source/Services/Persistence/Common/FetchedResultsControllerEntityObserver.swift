//
//  FetchedResultsControllerEntityObserver.swift
//  theRush
//
//  Created by Minhaz Mohammad on 8/29/19.
//  Copyright © 2019 SMPL Inc. All rights reserved.
//

import CoreData
import Foundation
import RxSwift

final class FetchedResultsControllerEntityObserver<T: NSFetchRequestResult> : NSObject, NSFetchedResultsControllerDelegate {
    
    typealias Observer = AnyObserver<[T]>
    
    fileprivate let disposeBag = DisposeBag()
    fileprivate let frc: NSFetchedResultsController<T>
    fileprivate let observer: Observer
    
    
    init(observer: Observer, fetchRequest: NSFetchRequest<T>, managedObjectContext context: NSManagedObjectContext, sectionNameKeyPath: String?, cacheName: String?) {
        self.observer = observer
        
        
        self.frc = NSFetchedResultsController(fetchRequest: fetchRequest,
                                              managedObjectContext: context,
                                              sectionNameKeyPath: sectionNameKeyPath,
                                              cacheName: cacheName)
        super.init()
        
        context.perform { [weak self] in
            self?.frc.delegate = self
            
            do {
                try self?.frc.performFetch()
            } catch let e {
                observer.on(.error(e))
            }
            
            self?.sendNextElement()
        }
    }
    
    fileprivate func sendNextElement() {
        frc.managedObjectContext.perform { [weak self] in
            let entities = self?.frc.fetchedObjects ?? []
            self?.observer.on(.next(entities))
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        sendNextElement()
    }
    
}

extension FetchedResultsControllerEntityObserver : Disposable {
    
    func dispose() {
        frc.delegate = nil
    }
    
}
