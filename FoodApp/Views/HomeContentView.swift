import SwiftUI

struct HomeContentView: View {
    @StateObject var cartViewModel: CartViewModel  // Use @StateObject for persistence
    
    // SearchBar Implementation
    @State var searchText = ""
    
    var filteredFoodModel: [FoodDataModel] {
        guard !searchText.isEmpty else { return viewModel }
        return viewModel.filter { $0.name.localizedStandardContains(searchText) }
    }
    
    // State variables for toggle
    @State private var switchImage = true
    @State private var switchList = false
    
    @Binding var showSideMenu: Bool
    
    @Namespace var namespace
    
    @State private var menuOffset: CGFloat = -250  // Initial offset for the side menu
    @State private var dragOffset: CGFloat = 0     // Drag offset during the gesture
    
    @State var isDark = false
    
    // Data for FoodModel
    var viewModel: [FoodDataModel] = [
        FoodDataModel(name: "FastFood", image: "fastFood", price: 30, rating: 240),
        FoodDataModel(name: "Coke", image: "coke", price: 50, rating: 420),
        FoodDataModel(name: "Ramen", image: "ramen", price: 25, rating: 420),
        FoodDataModel(name: "Salad", image: "salad", price: 65, rating: 420),
        FoodDataModel(name: "Burger", image: "hamburger", price: 90, rating: 420),
        FoodDataModel(name: "Donut", image: "donut", price: 15, rating: 420),
        FoodDataModel(name: "ThaiFood", image: "thaiFood", price: 40, rating: 420),
        FoodDataModel(name: "Vegetable", image: "vegetable", price: 72, rating: 420),
        FoodDataModel(name: "EggDiet", image: "eggDiet", price: 84, rating: 420),
        FoodDataModel(name: "Biryani", image: "biryani", price: 32, rating: 420),
        FoodDataModel(name: "BurgerCombo", image: "burgerCombo", price: 100, rating: 500)
    ]
    
    var body: some View {
        ZStack {
            // Main Content View
            NavigationStack {
                ScrollView {
                    VStack(alignment: .leading, spacing: 22) {
                        // Top Bar
                        HStack {
                            Button(action: {
                                withAnimation {
                                    showSideMenu.toggle()
                                }
                            }) {
                                Image(systemName: "line.horizontal.3.decrease")
                                    .font(.title)
                            }
                            
                            Spacer()
                            
                            Text("Hello Yousoff!")
                                .bold()
                                .font(.title)
                            
                            Spacer()
                            
                            Image("man")
                                .resizable()
                                .frame(width: 40, height: 40)
                        }
                        .foregroundColor(.primary)
                        .padding()
                        
                        // Search Bar
                        HStack {
                            SearchView(title: "Search Restaurant", searchText: $searchText)
                            
                            Button(action: {
                                withAnimation {
                                    switchImage.toggle()
                                    switchList.toggle()
                                }
                            }) {
                                Image(systemName: switchImage ? "rectangle.grid.2x2.fill" : "rectangle.grid.1x2.fill")
                                    .font(.largeTitle)
                                    .foregroundColor(.gray)
                            }
                        }
                        .padding(.horizontal)
                        
                        // FoodMenu View
                        if !switchList {
                            LazyVGrid(columns: Array(repeating: GridItem(), count: 2), spacing: 12) {
                                ForEach(filteredFoodModel, id: \.self) { model in
                                    VerticalFoodLayout(viewModel: model, namespace: namespace, cartViewModel: cartViewModel)
                                }
                            }
                        } else {
                            LazyVGrid(columns: Array(repeating: GridItem(), count: 1), spacing: 12) {
                                ForEach(filteredFoodModel, id: \.self) { model in
                                    HorizontalFoodLayout(cartviewModel: cartViewModel, viewModel: model, namespace: namespace)
                                }
                            }
                        }
                    }
                    .padding(.vertical, 40)
                }
                .ignoresSafeArea(.container)
            }
            
            //aplying gesture to whole view
            .offset(x: showSideMenu ? 250 : 0)  // Shift the main content when the menu is open
        }
        .gesture(
            DragGesture()
                .onChanged { value in
                    dragOffset = value.translation.width
                }
                .onEnded { value in
                    withAnimation {
                        if dragOffset > 100 {
                            showSideMenu = true
                            menuOffset = 0
                        } else if dragOffset < -100 {
                            showSideMenu = false
                            menuOffset = -250
                        }
                        dragOffset = 0
                    }
                }
        )
    }
}

struct HomeContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeContentView(
            cartViewModel: CartViewModel(),
            showSideMenu: .constant(false)
        )
    }
}
