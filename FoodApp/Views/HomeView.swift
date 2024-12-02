import SwiftUI

enum viewSelection: String, CaseIterable {
    case home
    case cart
    case favorites
    case trash
}

struct HomeView: View {
    var cartViewModel: CartViewModel
    
    @State private var offsetX: CGFloat = 0
    @State private var showSideOptions: Bool = false
    @State private var scaleEffect: CGFloat = 1.0
    
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false
    @State var selection: viewSelection = .home
    
    var body: some View {
        ZStack(alignment: .leading) {
            // Side menu view
            if showSideOptions {
                SideMenuView(selection: $selection)
                    .transition(.move(edge: .leading))
                    .zIndex(1)
                    .frame(width: 220)
            }
            
            // Dynamically display the content based on `selection`
            contentView(for: selection)
                .scaleEffect(scaleEffect)
                .offset(x: offsetX)
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            let dragDistance = value.translation.width
                            if dragDistance > 0 {
                                offsetX = min(dragDistance, 220)
                                scaleEffect = 1.0 - (dragDistance / 1000)
                            }
                        }
                        .onEnded { value in
                            let dragDistance = value.translation.width
                            withAnimation(.easeInOut) {
                                if dragDistance >= 150 {
                                    offsetX = 220
                                    scaleEffect = 0.95
                                    showSideOptions = true
                                } else {
                                    offsetX = 0
                                    scaleEffect = 1.0
                                    showSideOptions = false
                                }
                            }
                        }
                )
                .onChange(of: selection) { _ in
                    // Reset view state when selection changes
                    withAnimation {
                        offsetX = 0
                        scaleEffect = 1.0
                        showSideOptions = false
                    }
                }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .preferredColorScheme(isDarkMode ? .dark : .light) // Apply dark mode globally
        .background(isDarkMode ? Color.black : Color.white) // Background color for light/dark mode
    }
    
    @ViewBuilder
    private func contentView(for selection: viewSelection) -> some View {
        switch selection {
        case .home:
            HomeContentView(cartViewModel: cartViewModel, showSideMenu: $showSideOptions)
        case .cart:
            CartView(cartViewModel: cartViewModel)
        case .favorites:
            Text("Favorites View")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.blue.opacity(0.1))
        case .trash:
            Text("Trash View")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.red.opacity(0.1))
        }
    }
}


#Preview {
    HomeView(cartViewModel: CartViewModel())
}
