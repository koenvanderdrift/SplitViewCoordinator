# SplitViewCoordinator

This is an attempt to use a Coordinator with a UISplitViewController. Based on MasterDetail project in Xcode.

To make this work, the Coordinator needs to know about the segue destination, otherwise the detail is never updated. By design, UISplitViewController replaces the DetailViewController and its NavigationController with every segue. So we cannot keep a reference to the DetailViewController and swap out its contents. The Coordinator also needs to know about the segue identifier, since it needs to make decisions if there are more than one segues. 

<s>So, for now I am just passing the segue to the Coordinator (which is a delegate of the MasterViewController). I have seen articles where they use swiffling, but that seems overly complicated.</s>

Swizzling is actually not that complicated. Updated project.
