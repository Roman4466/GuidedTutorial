//
//  TutorialCoordinator.swift
//  GuidedTutorial
//
//  Created by Roman Malynovsky on 14.10.2025.
//

import SwiftUI
import Combine

@MainActor
public class TutorialCoordinator: ObservableObject {
    @Published public private(set) var currentFlow: TutorialFlow?
    @Published public private(set) var currentStepIndex: Int = 0
    @Published public private(set) var flowState: TutorialFlowState = .notStarted
    @Published public private(set) var targetFrames: [String: CGRect] = [:]
    @Published public private(set) var isPresented: Bool = false

    private var eventHandlers: [(TutorialEvent) -> Void] = []
    private var cancellables = Set<AnyCancellable>()

    /// ScrollViewProxy for automatic scrolling to tutorial targets
    private weak var scrollProxy: ScrollViewProxy?

    /// Enables automatic scrolling to targets when they change
    public var autoScrollEnabled: Bool = true

    /// Duration for scroll animation
    public var scrollAnimationDuration: Double = 0.5

    public init() {}

    // MARK: - Public Methods

    public func startFlow(_ flow: TutorialFlow) {
        guard !flow.steps.isEmpty else { return }

        currentFlow = flow
        currentStepIndex = 0
        flowState = .inProgress(currentStepIndex: 0)
        isPresented = true

        notifyEvent(.tutorialStarted)
        notifyEvent(.stepStarted(stepId: flow.steps[0].id))

        // Scroll to first target with a small delay to allow view to render
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
            self?.scrollToCurrentTarget()
        }
    }

    public func nextStep() {
        guard let flow = currentFlow else { return }
        guard currentStepIndex < flow.steps.count - 1 else {
            completeTutorial()
            return
        }

        notifyEvent(.stepCompleted(stepId: flow.steps[currentStepIndex].id))

        currentStepIndex += 1
        flowState = .inProgress(currentStepIndex: currentStepIndex)

        notifyEvent(.stepStarted(stepId: flow.steps[currentStepIndex].id))

        // Auto-scroll to new target
        scrollToCurrentTarget()
    }

    public func skipToStep(index: Int) {
        guard let flow = currentFlow else { return }
        guard index >= 0 && index < flow.steps.count else { return }

        notifyEvent(.stepSkipped(stepId: flow.steps[currentStepIndex].id))

        currentStepIndex = index
        flowState = .inProgress(currentStepIndex: currentStepIndex)

        notifyEvent(.stepStarted(stepId: flow.steps[currentStepIndex].id))
    }

    public func skipToStep(id: UUID) {
        guard let flow = currentFlow else { return }
        guard let index = flow.steps.firstIndex(where: { $0.id == id }) else { return }

        skipToStep(index: index)
    }

    public func skipTutorial() {
        guard let flow = currentFlow else { return }

        notifyEvent(.stepSkipped(stepId: flow.steps[currentStepIndex].id))
        notifyEvent(.tutorialSkipped)

        flowState = .skipped
        isPresented = false

        flow.onSkip?()

        resetState()
    }

    public func completeTutorial() {
        guard let flow = currentFlow else { return }

        notifyEvent(.stepCompleted(stepId: flow.steps[currentStepIndex].id))
        notifyEvent(.tutorialCompleted)

        flowState = .completed
        isPresented = false

        flow.onComplete?()

        resetState()
    }

    public func registerTargetFrame(key: String, frame: CGRect) {
        targetFrames[key] = frame
    }

    /// Registers a ScrollViewProxy for automatic scrolling
    /// - Parameter proxy: The ScrollViewProxy from ScrollViewReader
    public func registerScrollProxy(_ proxy: ScrollViewProxy) {
        self.scrollProxy = proxy
    }

    /// Scrolls to the current tutorial target if auto-scroll is enabled
    /// - Parameter animated: Whether to animate the scroll (default: true)
    public func scrollToCurrentTarget(animated: Bool = true) {
        guard autoScrollEnabled,
              let scrollProxy = scrollProxy,
              let currentStep = currentStep else {
            return
        }

        let targetKey = currentStep.targetKey

        if animated {
            withAnimation(.easeInOut(duration: scrollAnimationDuration)) {
                scrollProxy.scrollTo(targetKey, anchor: .center)
            }
        } else {
            scrollProxy.scrollTo(targetKey, anchor: .center)
        }
    }

    public func addEventHandler(_ handler: @escaping (TutorialEvent) -> Void) {
        eventHandlers.append(handler)
    }

    public var currentStep: TutorialStep? {
        guard let flow = currentFlow,
              currentStepIndex >= 0,
              currentStepIndex < flow.steps.count else {
            return nil
        }
        return flow.steps[currentStepIndex]
    }

    // MARK: - Private Methods

    private func notifyEvent(_ event: TutorialEvent) {
        eventHandlers.forEach { $0(event) }
    }

    private func resetState() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            self?.currentFlow = nil
            self?.currentStepIndex = 0
            self?.targetFrames.removeAll()
        }
    }
}
