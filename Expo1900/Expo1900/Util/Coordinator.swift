//
//  Coordinator.swift
//  Expo1900
//
//  Created by Hyungmin Lee on 2023/07/05.
//

protocol Coordinators: AnyObject {
    var childCoordinators: [Coordinators] { get set }
    func start()
}
