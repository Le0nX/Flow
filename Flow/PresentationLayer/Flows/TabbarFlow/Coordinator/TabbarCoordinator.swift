//
//  TabbarCoordinator.swift
//  Flow
//
//  Created by workmachine on 07.08.2018.
//  Copyright © 2018 Beslan Tularov Ramazanovich. All rights reserved.
//

import UIKit

class TabbarCoordinator: BaseCoordinator, TabbarCoordinatorOutput {
	
	var finishFlow: (() -> Void)?
	
	private let tabbarOutput: FlowTabbarCoordinatorOutput
	private let coordinatorFactory: CoordinatorFactory
	
	init(tabbarOutput: FlowTabbarCoordinatorOutput, coordinatorFactory: CoordinatorFactory) {
		
		self.tabbarOutput = tabbarOutput
		self.coordinatorFactory = coordinatorFactory
	}
	
	override func start() {
		
		tabbarOutput.onFeedFlow = runFeedFlow()
		tabbarOutput.onProfileFlow = runProfileFlow()
	}
	
	private func runFeedFlow() -> ((UINavigationController) -> ()) {
		
		return { navigationController in
			
			let feedCoordinator = self.coordinatorFactory.produceFeedCoordinator(navigationController: navigationController, flowFactory: FlowFactoryImp())
			feedCoordinator.start()
			self.addDependency(feedCoordinator)
		}
	}
	
	private func runProfileFlow() -> ((UINavigationController) -> ()) {
		
		return { navigationController in
			
			var profileCoordinator = self.coordinatorFactory.produceProfileCoordinator(navigationController: navigationController, flowFactory: FlowFactoryImp())
			profileCoordinator.finishFlow = { [weak self] in
				
				self?.finishFlow?()
			}
			profileCoordinator.start()
			self.addDependency(profileCoordinator)
		}
	}
}
