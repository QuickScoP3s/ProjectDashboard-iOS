//
//  TaskListViewModel.swift
//  ProjectDetails
//
//  Created by Waut Wyffels on 10/08/2020.
//  Copyright © 2020 Quick Development. All rights reserved.
//

import UIKit
import Core
import Networking
import Utils

class TaskListViewModel: NSObject {

    private let projectsService: ProjectsService
    private weak var coordinator: ProjectDetailsCoordinator?
    
    var items: [ProjectTask]?

    init(networking: Networking, coordinator: ProjectDetailsCoordinator) {
        self.projectsService = ProjectsService(networking: networking)
        self.coordinator = coordinator
    }
    
    func fetchTasks(completedTasks completed: Bool, completionHandler: @escaping ((Result<Void, Error>) -> Void)) {
        self.items = [
            ProjectTask(title: "Simple Task"),
            ProjectTask(title: "Task with description", description: "Some description"),
            ProjectTask(title: "Task with loooong description", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras ligula leo, viverra id consectetur id, posuere vitae felis. Vivamus interdum lacus quis accumsan bibendum. In imperdiet fringilla magna vitae posuere. Maecenas vel ultrices mi. Sed sed ultrices velit, eget aliquam purus. Etiam ultrices sed metus et blandit. Curabitur volutpat, magna id cursus laoreet, turpis ipsum auctor nisi, a tristique elit odio vel nulla. Morbi at faucibus tellus. Donec quis justo id ipsum sollicitudin egestas. Ut varius tincidunt ex, facilisis posuere purus ultrices id. Donec et fringilla eros, nec iaculis arcu. Vivamus in mi purus. Vestibulum sed varius risus, sed interdum quam. Nunc sit amet tempor libero, ac fringilla elit. Mauris ornare eros at diam bibendum, sit amet luctus dui hendrerit.")
        ]
        
        completionHandler(Result.success(()))
    }
}

// MARK: - UITableViewDataSource

extension TaskListViewModel: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath)
        
        guard let task = items?[indexPath.row] else {
            return cell
        }
        
        cell.textLabel?.text = task.title
        if (!task.description.isEmpty) {
            cell.detailTextLabel?.text = task.description
        }
        
        return cell
    }
}

// MARK: - UITableViewDataSource

extension TaskListViewModel: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let completeAction = UIContextualAction(style: .normal, title: "Complete") { (action, view, handler) in
            handler(true)
        }
        
        completeAction.image = UIImage(systemName: "checkmark.circle")
        completeAction.backgroundColor = UIColor(hex: "#228B22")
        
        let configuration = UISwipeActionsConfiguration(actions: [completeAction])
        configuration.performsFirstActionWithFullSwipe = true
        
        return configuration
    }
}
