//
//  ProfilePresenter.swift
//  Flow
//
//  Created by Beslan Tularov on 27/07/2018.
//  Copyright © 2018 Flow. All rights reserved.
//

class ProfilePresenter: ProfileModuleInput, ProfileViewOutput, ProfileInteractorOutput {

    weak var view: ProfileViewInput!
	weak var coordinator: ProfileViewCoordinatorOutput!
    var interactor: ProfileInteractorInput!

	func viewDidLoad() {
		view.setupInitialState()
	}
	
	func exit() {
		coordinator.onExit?()
	}
}
