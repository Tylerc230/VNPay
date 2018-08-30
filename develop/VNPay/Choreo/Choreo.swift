//
//  Choreo.swift
//  VNPay
//
//  Created by Tyler Casselman on 8/25/18.
//  Copyright © 2018 13bit. All rights reserved.
//

import Foundation
class Choreo {
    private var phases: [AnimationPhase] = []
    private var prepareCallback: (() -> ())?
    typealias AnimationCallback = (TimeInterval) -> ()
    typealias ViewAnimationCallback = (UIView, TimeInterval) -> ()
    private struct AnimationPhase {
        let start: Double
        let duration: Double
        let animations: AnimationCallback
    }
    
    func prepareAnimations(_ prepareCallback: @escaping () -> ()) -> Choreo {
        self.prepareCallback = prepareCallback
        return self
    }
    
    func addAnimationPhase(startFraction: Double, durationFraction: Double, animations: @escaping AnimationCallback) -> Choreo {
        let newPhase = AnimationPhase(start: startFraction, duration: durationFraction, animations: animations)
        phases.append(newPhase)
        return self
    }
    
    func addStaggeredAnimation(views: [UIView], startFraction: Double, durationFraction: Double, delayFraction: Double, animation: @escaping ViewAnimationCallback) -> Choreo {
        let newPhase = AnimationPhase(start: startFraction, duration: durationFraction) { totalDuration in
            let viewCount = views.count
            let delay = delayFraction * totalDuration
            let totalDelay = Double(viewCount - 1) * delay
            let animationTimePerView = totalDuration - totalDelay
            views.enumerated().forEach { args in
                let (offset, view) = args
                DispatchQueue.main.asyncAfter(deadline: .now() + Double(offset) * delay) {
                    animation(view, animationTimePerView)
                }
            }
        }
        phases.append(newPhase)
        return self
    }
    
    func animate(totalDuration: TimeInterval) {
        prepareCallback?()
        phases.forEach { phase in
            let startTime = phase.start * totalDuration
            let duration = phase.duration * totalDuration
            DispatchQueue.main.asyncAfter(deadline: .now() + startTime) {
                phase.animations(duration)
            }
        }
        
    }
}
