import SwiftUI

struct CartView: View {
    
    @ObservedObject var cartViewModel: CartViewModel // Observes changes in cart items
    
    var body: some View {
        NavigationStack {
            if cartViewModel.cartItems.isEmpty {
                VStack {
                    Text("Please add items to the cart from Food Menu")
                        .font(.custom("verdana", size: 18))
                        .multilineTextAlignment(.center)
                        .padding()
                    
                    Image(systemName: "cart")
                        .resizable()
                        .frame(width: 200, height: 200)
                }
                .padding()
             
            }else {
                List {
                    ForEach(cartViewModel.cartItems, id: \.self) { item in
                        
                        HStack {
                            Image(item.image)
                                .resizable()
                                .frame(width: 50, height: 50)
                                .cornerRadius(8)
                            
                            Spacer()
                            
                            Text(item.name)
                                .font(.headline)
                            
                            Spacer()
                            
                            Text("\(item.price) rs")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        .padding(.vertical, 5)
                    }
                    .onDelete(perform: deleteCartItem) // Attach optimized delete method
                }
                .listStyle(.insetGrouped) // Modern list style
                .navigationTitle("Your Order")
            }
        }
    }
    
    //Delete Functionality
    func deleteCartItem(at offset : IndexSet){
        cartViewModel.cartItems.remove(atOffsets: offset)
    }
}

#Preview {
    CartView(cartViewModel: CartViewModel())  // Pass the CartViewModel instance
}
