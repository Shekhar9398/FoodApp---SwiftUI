import SwiftUI

struct VerticalFoodLayout: View {
    
    var viewModel : FoodDataModel
    var namespace : Namespace.ID
    var cartViewModel : CartViewModel  // Pass CartViewModel instance
    
    var body: some View {
        VStack {
            Image(viewModel.image)
                .resizable()
                .matchedGeometryEffect(id: viewModel.image, in: namespace)
                .frame(width: 90, height: 90)
            
            Spacer()
            
            VStack(alignment: .leading, spacing: 12) {
                Text(viewModel.name)
                    .bold()
                
                HStack {
                    Text("\(viewModel.price)rs")
                    Spacer()
                    
                    Image(systemName: "star.leadinghalf.filled")
                        .foregroundColor(.red)
                    
                    Text("\(viewModel.rating)")
                        .font(.subheadline)
                }
            }
            .padding(.horizontal)
        }
        .padding()
        .frame(width: 175, height: 195)
        .background(Color.gray.opacity(0.4), in: RoundedRectangle(cornerRadius: 14))
        .overlay(alignment: .topTrailing) {
            Button {
                cartViewModel.addItemToCart(item: viewModel)  // Add item to cart
            } label: {
                Image(systemName: "plus")
                    .padding(10)
                    .background(.gray.opacity(0.2), in:
                                    UnevenRoundedRectangle(topLeadingRadius: 0, bottomLeadingRadius: 15, bottomTrailingRadius: 0, topTrailingRadius: 15, style: .continuous ))
                    .foregroundColor(.primary)
            }
        }
    }
}

//namespace affects the default preview
struct VerticalFoodLayoutPreview: PreviewProvider {
    @Namespace static var namespace
    
    static var previews: some View {
        VerticalFoodLayout(viewModel: FoodDataModel(name: "Burger", image: "hamburger", price: 20, rating: 30), namespace: namespace, cartViewModel: CartViewModel())  // Pass CartViewModel here
    }
}
