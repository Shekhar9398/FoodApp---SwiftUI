
import SwiftUI

struct HorizontalFoodLayout: View {
    var cartviewModel : CartViewModel
    var viewModel : FoodDataModel
    var namespace : Namespace.ID
    
    var body: some View {
   
            HStack{
                Image(viewModel.image)
                    .resizable()
                    .matchedGeometryEffect(id: viewModel.image, in: namespace)
                    .frame(width: 50, height: 50)
                    .padding(.leading)
                
                VStack(alignment: .leading, spacing: 12){
                    
                    Text(viewModel.name)
                        .bold()
                    
                    HStack{
                        Text("\(viewModel.price)rs")
                        
                        Spacer()
                        
                        Image(systemName: "star.leadinghalf.filled")
                            .foregroundColor(.red)

                        Text("\(viewModel.rating)")
                            
                    }
                    .padding(.trailing, 60)
                }
                .padding()
            }
            .frame(height: 80)
            .background(.gray.opacity(0.3), in: RoundedRectangle(cornerRadius: 15))
        
            .overlay(alignment: .trailing) {
                Button {
                    cartviewModel.addItemToCart(item: viewModel)
                } label: {
                    Image(systemName: "plus")
                        .frame(width: 50, height: 50)
                        .background(.gray.opacity(0.2), in: RoundedRectangle(cornerRadius: 15))
                        .foregroundColor(.primary)
                        .padding()
                }
            }

    }
}

//namespace affects the default preview
struct HorizontalFoodLayout_Previews: PreviewProvider {
    @Namespace static var namespace
    
    static var previews: some View {
        HorizontalFoodLayout(
            cartviewModel: CartViewModel(), viewModel: FoodDataModel(name: "Coke", image: "coke", price: 40, rating: 370),
            namespace: namespace
        )
    }
}
