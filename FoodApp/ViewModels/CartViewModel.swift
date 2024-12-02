
import SwiftUI

class CartViewModel : ObservableObject {
    
    @Published var cartItems : [FoodDataModel] = []
    
    func addItemToCart(item : FoodDataModel){
        cartItems.append(item)
    }
}
