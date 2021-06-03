List of things that has been done in this project:

-Product was a Codable object. It has been abstracted by conforming ProductPresentable protocol. So an object that is using for networking is not passing all around.

-A network layer implemented. Calls are done in ServiceManager class. In order to use the ServiceManager DataService classes needs to be implemented. Hence, SPM dependencies removed.

-Memory Services implemented for holding products, adding, removing products and for any other product related actions.

-Since this is a small project I decided to use MVP architect with Coordinator pattern. Of course, more comprehensive architectures such as VIPER or Clean can be implemented but in my opinion this might be over engineered for this small size project. Coordinator creates ViewController and Presenter instances, and navigations completed via Coordinator classes. 

-To use Coordinator more efficiently, entry points of app removed. Instead, an AppDelegate initialization implemented programmatically with a Coordinator.

-A SwiftUI implementation of CatalogueViewController made. Switching between 2 implementation can be done in MainCoordinator with toggling them. A comment line left there.

-Basket and Wishlist changes are inform over Combine Framework to TabBar.

-Images replaced with SF Images.

-ViewControllers are divided into scene folders to better arrangement.

-TableViewCells and CollectionViewCell moved into .xib files.

-Access modifiers are revised.

-Constant folder mostly filled with enumerated String names.

-Checkout button BasketViewController implemented with removing items from Memory Service. It changes the stock counts of selected products.

-Unfortunately, due to time restriction test classes couldn't be written.