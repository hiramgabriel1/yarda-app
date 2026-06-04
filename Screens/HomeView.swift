import SwiftUI

struct HomeView: View {
    @State private var selectedCategory = "Todo"
    @State private var searchText = ""
    @State private var selectedProduct: Product?

    let categories = [
        (emoji: "✦", name: "Todo"),
        (emoji: "🍔", name: "Comida"),
        (emoji: "👕", name: "Ropa"),
        (emoji: "🧵", name: "Manualidades"),
        (emoji: "⚡", name: "Servicios"),
        (emoji: "📦", name: "Otros"),
    ]

    let featuredSellers = [
        FeaturedSeller(name: "Sofía Reyes", school: "IPN", rating: 4.9, sales: 134, badge: "Top Vendedor"),
        FeaturedSeller(name: "Carlos Mendez", school: "UNAM", rating: 4.7, sales: 89, badge: "Confiable"),
    ]

    let products = [
        Product(title: "Calcetines tejidos a mano", price: 80, seller: "Sofía R.", tag: "Nuevo", description: "Calcetines tejidos a mano con estambre 100% acrílico suave."),
        Product(title: "Burritos de frijol y queso", price: 35, seller: "Diego M.", tag: nil, description: "Burritos frescos con frijol y queso."),
        Product(title: "Aretes de resina", price: 120, seller: "Valentina P.", tag: "¡Oferta!", description: "Aretes artesanales de resina."),
        Product(title: "Camiseta vintage Tec", price: 200, seller: "Carlos M.", tag: nil, description: "Camiseta vintage del Tec de Monterrey."),
        Product(title: "Asesoría de Cálculo", price: 150, seller: "Marcos L.", tag: nil, description: "Asesoría personalizada de cálculo."),
        Product(title: "Pulseras de macramé", price: 60, seller: "Sofía R.", tag: nil, description: "Pulseras tejidas en macramé."),
    ]

    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                headerSection

                searchSection

                categoryPillsSection

                featuredSellersSection

                productsSection

                Color.clear.frame(height: 100)
            }
        }
        .background(AppTheme.background)
        .navigationBarHidden(true)
        .safeAreaInset(edge: .bottom) {
            tabBar
        }
    }

    private var headerSection: some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading, spacing: 2) {
                Text("Bienvenido de vuelta")
                    .font(.system(size: 12, weight: .medium))
                    .foregroundStyle(AppTheme.mutedForeground)

                Text("Hola, Andrea 👋")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundStyle(AppTheme.foreground)
                    .tracking(-0.4)
            }

            Spacer()

            Button(action: {}) {
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(AppTheme.input)
                        .frame(width: 40, height: 40)

                    Image(systemName: "bell.fill")
                        .font(.system(size: 18))
                        .foregroundStyle(AppTheme.foreground)
                }

                Circle()
                    .fill(AppTheme.brandPrimary)
                    .frame(width: 12, height: 12)
                    .overlay(
                        Circle()
                            .stroke(AppTheme.background, lineWidth: 2)
                    )
                    .offset(x: 8, y: -8)
            }
            .buttonStyle(.plain)
        }
        .padding(.horizontal, 20)
        .padding(.top, 8)
        .padding(.bottom, 4)
    }

    private var searchSection: some View {
        HStack(spacing: 10) {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 14, weight: .medium))
                .foregroundStyle(AppTheme.mutedForeground)

            Text("Busca productos en tu escuela…")
                .font(.system(size: 15))
                .foregroundStyle(AppTheme.mutedForeground)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(AppTheme.input)
        .cornerRadius(16)
        .padding(.horizontal, 20)
        .padding(.vertical, 12)
    }

    private var categoryPillsSection: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                ForEach(categories, id: \.name) { category in
                    CategoryPill(
                        emoji: category.emoji,
                        title: category.name,
                        isSelected: selectedCategory == category.name
                    ) {
                        selectedCategory = category.name
                    }
                }
            }
            .padding(.horizontal, 20)
        }
        .padding(.bottom, 16)
    }

    private var featuredSellersSection: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Text("⭐ Destacados")
                    .font(.system(size: 17, weight: .bold))
                    .foregroundStyle(AppTheme.foreground)
                    .tracking(-0.3)

                Spacer()

                Button(action: {}) {
                    Text("Ver todos")
                        .font(.system(size: 13, weight: .medium))
                        .foregroundStyle(AppTheme.brandPrimary)
                }
                .buttonStyle(.plain)
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 12)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(featuredSellers) { seller in
                        FeaturedSellerCard(seller: seller)
                    }
                }
                .padding(.horizontal, 20)
            }
        }
        .padding(.bottom, 16)
    }

    private var productsSection: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Text("Productos recientes")
                    .font(.system(size: 17, weight: .bold))
                    .foregroundStyle(AppTheme.foreground)
                    .tracking(-0.3)

                Spacer()

                Button(action: {}) {
                    Text("Ver más")
                        .font(.system(size: 13, weight: .medium))
                        .foregroundStyle(AppTheme.brandPrimary)
                }
                .buttonStyle(.plain)
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 12)

            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                ForEach(products) { product in
                    Button(action: { selectedProduct = product }) {
                        ProductCard(product: product)
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.horizontal, 20)
        }
        .fullScreenCover(item: $selectedProduct) { product in
            ProductDetailView(product: product)
        }
    }

    private var tabBar: some View {
        HStack(spacing: 0) {
            TabBarItem(
                icon: "house.fill",
                label: "Inicio",
                isSelected: true
            ) {}
            .frame(maxWidth: .infinity)

            TabBarItem(
                icon: "magnifyingglass",
                label: "Buscar",
                isSelected: false
            ) {}
            .frame(maxWidth: .infinity)

            TabBarItem(
                icon: "plus",
                label: "Vender",
                isSelected: false,
                isElevated: true
            ) {}
            .frame(maxWidth: .infinity)

            TabBarItem(
                icon: "bag.fill",
                label: "Pedidos",
                isSelected: false
            ) {}
            .frame(maxWidth: .infinity)

            TabBarItem(
                icon: "person.fill",
                label: "Perfil",
                isSelected: false
            ) {}
            .frame(maxWidth: .infinity)
        }
        .padding(.top, 6)
        .padding(.bottom, 0)
        .background(AppTheme.background)
        .overlay(
            Rectangle()
                .frame(height: 1)
                .foregroundStyle(AppTheme.border),
            alignment: .top
        )
    }
}

struct CategoryPill: View {
    let emoji: String
    let title: String
    let isSelected: Bool
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            HStack(spacing: 6) {
                Text(emoji)
                    .font(.system(size: 14))

                Text(title)
                    .font(.system(size: 13, weight: .medium))
                    .tracking(-0.1)
            }
            .foregroundStyle(isSelected ? AppTheme.brandPrimaryForeground : AppTheme.foreground)
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .background(isSelected ? AppTheme.brandPrimary : AppTheme.input)
            .cornerRadius(16)
        }
        .buttonStyle(.plain)
    }
}

struct FeaturedSeller: Identifiable {
    let id = UUID()
    let name: String
    let school: String
    let rating: Double
    let sales: Int
    let badge: String
}

struct FeaturedSellerCard: View {
    let seller: FeaturedSeller

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(spacing: 12) {
                RoundedRectangle(cornerRadius: 12)
                    .fill(AppTheme.input)
                    .frame(width: 44, height: 44)

                VStack(alignment: .leading, spacing: 2) {
                    Text(seller.name)
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundStyle(AppTheme.foreground)
                        .lineLimit(1)

                    Text(seller.school)
                        .font(.system(size: 12))
                        .foregroundStyle(AppTheme.mutedForeground)
                }

                Spacer()
            }
            .padding(.bottom, 12)

            HStack(spacing: 2) {
                ForEach(0..<5, id: \.self) { _ in
                    Image(systemName: "star.fill")
                        .font(.system(size: 12))
                        .foregroundStyle(AppTheme.brandPrimary)
                }

                Text(String(format: "%.1f", seller.rating))
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundStyle(AppTheme.foreground)
                    .padding(.leading, 2)
            }
            .padding(.bottom, 8)

            HStack {
                Text("\(seller.sales) ventas")
                    .font(.system(size: 12))
                    .foregroundStyle(AppTheme.mutedForeground)

                Spacer()

                Text(seller.badge)
                    .font(.system(size: 12, weight: .medium))
                    .foregroundStyle(AppTheme.brandPrimary)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 2)
                    .background(AppTheme.brandSecondary)
                    .cornerRadius(8)
            }
        }
        .padding(16)
        .background(AppTheme.card)
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.08), radius: 2, x: 0, y: 1)
        .frame(width: 192)
    }
}

struct Product: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let price: Int
    let seller: String
    let tag: String?
    let description: String

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

struct ProductCard: View {
    let product: Product

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ZStack(alignment: .topLeading) {
                RoundedRectangle(cornerRadius: 12)
                    .fill(AppTheme.input)
                    .aspectRatio(1, contentMode: .fit)

                if let tag = product.tag {
                    Text(tag)
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundStyle(AppTheme.brandPrimaryForeground)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 2)
                        .background(AppTheme.brandPrimary)
                        .cornerRadius(8)
                        .padding(8)
                }
            }
            .padding(.bottom, 12)

            Text(product.title)
                .font(.system(size: 13, weight: .semibold))
                .foregroundStyle(AppTheme.foreground)
                .lineLimit(2)
                .lineSpacing(1.3)
                .padding(.bottom, 4)

            HStack(alignment: .firstTextBaseline, spacing: 2) {
                Text("$\(product.price)")
                    .font(.system(size: 15, weight: .bold))
                    .foregroundStyle(AppTheme.brandPrimary)

                Text("MXN")
                    .font(.system(size: 12, weight: .medium))
                    .foregroundStyle(AppTheme.mutedForeground)
            }
            .padding(.bottom, 2)

            Text(product.seller)
                .font(.system(size: 12))
                .foregroundStyle(AppTheme.mutedForeground)
        }
        .padding(12)
        .background(AppTheme.card)
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.07), radius: 2, x: 0, y: 1)
    }
}

struct TabBarItem: View {
    let icon: String
    let label: String
    let isSelected: Bool
    var isElevated: Bool = false
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            if isElevated {
                VStack(spacing: 4) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 16)
                            .fill(AppTheme.brandPrimary)
                            .frame(width: 48, height: 48)
                            .shadow(color: AppTheme.brandPrimary.opacity(0.38), radius: 14, x: 0, y: 4)

                        Image(systemName: icon)
                            .font(.system(size: 20, weight: .bold))
                            .foregroundStyle(.white)
                    }

                    Text(label)
                        .font(.system(size: 12, weight: .medium))
                        .foregroundStyle(AppTheme.brandPrimary)
                }
            } else {
                VStack(spacing: 2) {
                    Image(systemName: icon)
                        .font(.system(size: 22))
                        .foregroundStyle(isSelected ? AppTheme.brandPrimary : AppTheme.mutedForeground)

                    Text(label)
                        .font(.system(size: 12, weight: isSelected ? .semibold : .medium))
                        .foregroundStyle(isSelected ? AppTheme.brandPrimary : AppTheme.mutedForeground)
                }
                .frame(minWidth: 48)
            }
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    HomeView()
}
