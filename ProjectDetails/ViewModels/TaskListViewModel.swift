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
import LPSnackbar

class TaskListViewModel: NSObject {
	
	private let projectId: Int
	
	private let projectsService: ProjectsService
	private let tasksService: TasksService
	private weak var coordinator: ProjectDetailsCoordinator?
	
	var allTasks: [ProjectTask]?
	var selectedTasks: [ProjectTask]?
	
	var completedView: Bool?
	
	init(projectId: Int, networking: Networking, coordinator: ProjectDetailsCoordinator) {
		self.projectId = projectId
		self.projectsService = ProjectsService(networking: networking)
		self.tasksService = TasksService(networking: networking)
		self.coordinator = coordinator
	}
	
	func fetchTasks(completion: @escaping ((Result<Void, Error>) -> Void)) {
		projectsService.getTasks(forProjectId: self.projectId) { result in
			switch result {
				case .failure(let error):
					completion(Result.failure(error))
				case .success(let items):
					self.allTasks = items
					
					completion(Result.success(()))
			}
		}
	}
	
	func setStatus(forTask task: ProjectTask, completed: Bool, completion: @escaping ((Result<Void, Error>) -> Void)) {
		tasksService.put(status: completed, forId: task.id, completion: completion)
	}
	
	func deleteTask(_ task: ProjectTask, completion: @escaping ((Result<Void, Error>) -> Void)) {
		tasksService.deleteTask(byId: task.id) { completion($0.map { _ in () }) } // Convert Task success to Void
	}
	
	private func reloadData(on: UITableView) {
		self.showTasks(completed: self.completedView)
		on.reloadData()
	}
	
	func showTasks(completed: Bool? = nil) {
		self.completedView = completed
		
		guard let completed = completed else {
			selectedTasks = allTasks
			return
		}
		
		selectedTasks = allTasks?.filter { $0.isCompleted == completed }
	}
	
	@objc func addTask() {
		coordinator?.presentAddTask()
	}
}

// MARK: - UITableViewDataSource

extension TaskListViewModel: UITableViewDataSource {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return selectedTasks?.count ?? 0
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath)
		
		guard let task = selectedTasks?[indexPath.row] else {
			return cell
		}
		
		cell.textLabel?.text = task.title
		
		if (task.description.isEmpty) {
			cell.detailTextLabel?.text = nil
		}
		else {
			cell.detailTextLabel?.text = task.description
		}
		
		if (task.isCompleted) {
			cell.accessoryType = .checkmark
		}
		else {
			cell.accessoryType = .none
		}
		
		return cell
	}
}

// MARK: - UITableViewDataSource

extension TaskListViewModel: UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
		
		let task = selectedTasks![indexPath.row]
		coordinator?.presentTaskDetails(withId: task.id)
	}
	
	func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
		guard let task = selectedTasks?[indexPath.row] else {
			return nil
		}
		
		var actions = [UIContextualAction]()
		
		if !task.isCompleted {
			let completeAction = UIContextualAction(style: .normal, title: "Complete") { (action, view, handler) in
				self.updateTaskList(task, completed: true, tableView: tableView)
				handler(true)
			}
			
			completeAction.image = UIImage(systemName: "checkmark")
			completeAction.backgroundColor = UIColor(hex: "#228B22")
			actions.append(completeAction)
		}
		else {
			let undoAction = UIContextualAction(style: .normal, title: "Revert") { (action, view, handler) in
				self.updateTaskList(task, completed: false, tableView: tableView)
				handler(true)
			}
			
			undoAction.image = UIImage(systemName: "arrow.uturn.left")
			actions.append(undoAction)
		}
		
		let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action, view, handler) in
			self.deleteFromTaskList(task, tableView: tableView)
			handler(true)
		}
		
		deleteAction.image = UIImage(systemName: "trash")
		actions.append(deleteAction)
		
		let configuration = UISwipeActionsConfiguration(actions: actions)
		configuration.performsFirstActionWithFullSwipe = true
		
		return configuration
	}
	
	private func updateTaskList(_ task: ProjectTask, completed: Bool, tableView: UITableView) {
		guard let selectedIndex = self.allTasks?.firstIndex(where: { t -> Bool in
			return t.id == task.id
		})
		else {
				return
		}
		
		self.setStatus(forTask: task, completed: completed) { result in
			switch result {
				case .failure:
					self.allTasks?[selectedIndex].isCompleted = !completed
					self.reloadData(on: tableView)
					
					DispatchQueue.main.async {
						LPSnackbar.showSnack(title: "Failed to update task status", displayDuration: 1.0)
					}
				case .success:
					break
			}
		}
		
		self.allTasks?[selectedIndex].isCompleted = completed
		self.reloadData(on: tableView)
	}
	
	private func deleteFromTaskList(_ task: ProjectTask, tableView: UITableView) {
		guard let selectedIndex = self.allTasks?.firstIndex(where: { t -> Bool in
			return t.id == task.id
		})
		else {
				return
		}
		
		self.deleteTask(task) { result in
			switch result {
				case .failure:
					self.allTasks?.insert(task, at: selectedIndex)
					self.reloadData(on: tableView)
					
					DispatchQueue.main.async {
						LPSnackbar.showSnack(title: "Failed to delete task", displayDuration: 1.0)
					}
				case .success:
					break
			}
		}
		
		self.allTasks?.remove(at: selectedIndex)
		self.reloadData(on: tableView)
	}
}
