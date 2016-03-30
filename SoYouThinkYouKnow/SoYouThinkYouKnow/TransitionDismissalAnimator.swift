

import UIKit

class TransitionDismissalAnimator: NSObject, UIViewControllerAnimatedTransitioning {

    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 3.0
    }

    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        let fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!
        let toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
        let containerView = transitionContext.containerView()

        let animationDuration = self .transitionDuration(transitionContext)

        let snapshotView = fromViewController.view.resizableSnapshotViewFromRect(fromViewController.view.frame, afterScreenUpdates: true, withCapInsets: UIEdgeInsetsZero)
        snapshotView.center = toViewController.view.center
        containerView!.addSubview(snapshotView)

        fromViewController.view.alpha = 0.0

        let toViewControllerSnapshotView = toViewController.view.resizableSnapshotViewFromRect(toViewController.view.frame, afterScreenUpdates: true, withCapInsets: UIEdgeInsetsZero)
        containerView!.insertSubview(toViewControllerSnapshotView, belowSubview: snapshotView)

        UIView.animateWithDuration(animationDuration, animations: { () -> Void in
                snapshotView.transform = CGAffineTransformMakeScale(0.1, 0.1)
                snapshotView.alpha = 0.0
            }) { (finished) -> Void in
                toViewControllerSnapshotView.removeFromSuperview()
                snapshotView.removeFromSuperview()
                fromViewController.view.removeFromSuperview()
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
        }
    }

}
