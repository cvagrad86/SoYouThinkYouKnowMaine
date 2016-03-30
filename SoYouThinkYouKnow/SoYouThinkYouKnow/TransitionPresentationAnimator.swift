

import UIKit

class TransitionPresentationAnimator: NSObject, UIViewControllerAnimatedTransitioning {

    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 3.0
    }

    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        let fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!
        let toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
        let containerView = transitionContext.containerView()

        let animationDuration = self .transitionDuration(transitionContext)

        // take a snapshot of the detail ViewController so we can do whatever with it (cause it's only a view), and don't have to care about breaking constraints
        let snapshotView = toViewController.view.resizableSnapshotViewFromRect(toViewController.view.frame, afterScreenUpdates: true, withCapInsets: UIEdgeInsetsZero)
        snapshotView.transform = CGAffineTransformMakeScale(0.1, 0.1)
        snapshotView.center = fromViewController.view.center
        containerView!.addSubview(snapshotView)

        // hide the detail view until the snapshot is being animated
        toViewController.view.alpha = 0.0
        containerView!.addSubview(toViewController.view)

        UIView.animateWithDuration(animationDuration, delay: 3.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 20.0, options: [],
            animations: { () -> Void in
                snapshotView.transform = CGAffineTransformIdentity
            }, completion: { (finished) -> Void in
                snapshotView.removeFromSuperview()
                toViewController.view.alpha = 1.0
                transitionContext.completeTransition(finished)
        })
    }

}
