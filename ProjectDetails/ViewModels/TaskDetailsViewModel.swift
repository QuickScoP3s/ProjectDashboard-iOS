//
//  TaskDetailsViewModel.swift
//  ProjectDetails
//
//  Created by Waut Wyffels on 13/08/2020.
//  Copyright © 2020 Quick Development. All rights reserved.
//

import Core
import Networking

class TaskDetailsViewModel: NSObject {
	
	let projectId: Int
	let taskId: Int?

	private let tasksService: TasksService
	private weak var coordinator: ProjectDetailsCoordinator?
	
	init(projectId: Int, taskId: Int? = nil, networking: Networking, coordinator: ProjectDetailsCoordinator) {
		self.projectId = projectId
		self.taskId = taskId
		self.tasksService = TasksService(networking: networking)
		self.coordinator = coordinator
	}
	
	func fetchTaskDetails(completion: @escaping ((Result<ProjectTask, Error>) -> Void)) {
		guard let taskId = self.taskId else { return }
		
		tasksService.getTask(byId: taskId) { result in
			switch result {
				case .failure(let error):
					completion(Result.failure(error))
				case .success(let task):
					completion(Result.success(task))
			}
		}
	}
	
	func saveTask(title: String, description: String, assignee: User?, completion: @escaping ((Result<Void, Error>) -> Void)) {
		let task = ProjectTaskDTO(title: title,
										  description: description,
										  projectId: self.projectId,
										  assigneeId: assignee?.id)
		
		func complete(_ result: Result<Void, Error>) {
			switch result {
				case .failure(let error):
					completion(Result.failure(error))
				case .success:
					completion(Result.success(()))
					coordinator?.refreshTasksOverview()
			}
		}
		
		guard let taskId = self.taskId else {
			tasksService.post(task: task) { result in
				complete(result.map { _ in () }) // Convert Task success to Void
			}
			
			return
		}
		
		tasksService.put(task: task, withId: taskId, completion: complete)
	}
	
	@objc func selectAssignee() {
		coordinator?.presentPersonPicker(projectId: self.projectId)
	}
}
