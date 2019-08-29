//
//  BaseRepository.swift
//  theRush
//
//  Created by Minhaz Mohammad on 8/29/19.
//  Copyright © 2019 SMPL Inc. All rights reserved.
//

import CoreData
import Foundation
import RxSwift

final class ContextScheduler: ImmediateSchedulerType {
    
    fileprivate let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func schedule<StateType>(_ state: StateType, action: @escaping (StateType) -> Disposable) -> Disposable {
        
        let disposable = SingleAssignmentDisposable()
        
        context.perform {
            if disposable.isDisposed {
                return
            }
            disposable.setDisposable(action(state))
        }
        
        return disposable
    }
    
}

final class BaseRepository<T: CoreDataRepresentable>: AbstractRepository where T == T.CoreDataType.ModelType {
    
    fileprivate let context: NSManagedObjectContext
    fileprivate let scheduler: ContextScheduler
    
    init(context: NSManagedObjectContext) {
        self.context = context
        self.scheduler = ContextScheduler(context: context)
    }
    
    func query(with predicate: NSPredicate? = nil, sortDescriptors: [NSSortDescriptor]? = nil) -> Observable<[T]> {
        let request = T.CoreDataType.fetchRequest()
        request.predicate = predicate
        request.sortDescriptors = sortDescriptors
        return context.rx.entities(fetchRequest: request)
            .mapToModel()
            .subscribeOn(scheduler)
    }
    
    func save(entity: T) -> Observable<Void> {
        return entity.sync(in: context)
            .mapToVoid()
            .flatMapLatest(context.rx.save)
            .subscribeOn(scheduler)
    }
    
    func delete(entity: T) -> Observable<Void> {
        return entity.sync(in: context)
            .map({$0 as! NSManagedObject})
            .flatMapLatest(context.rx.delete)
    }
    
    func deleteWithoutSave(entity: T) -> Observable<Void> {
        return entity.sync(in: context)
            .map({$0 as! NSManagedObject})
            .flatMapLatest(context.rx.deleteWithoutSave)
    }
    
}
