import SwiftUI

struct ProductDetailView: View {
    let product: Product
    @Environment(\.dismiss) private var dismiss
    @State private var selectedPayment = PaymentMethod.card

    enum PaymentMethod {
        case card, cash, inPerson
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                imageHeroSection

                contentSection
                    .background(AppTheme.background)
                    .cornerRadius(24, corners: [.topLeft, .topRight])
                    .offset(y: -16)
            }
        }
        .background(AppTheme.background)
        .ignoresSafeArea(edges: .top)
        .navigationBarHidden(true)
        .safeAreaInset(edge: .bottom) {
            bottomActionBar
        }
    }

    private var imageHeroSection: some View {
        ZStack(alignment: .top) {
            RoundedRectangle(cornerRadius: 0)
                .fill(AppTheme.input)
                .aspectRatio(4.0 / 3.0, contentMode: .fit)

            LinearGradient(
                colors: [Color.black.opacity(0.32), .clear],
                startPoint: .top,
                endPoint: .bottom
            )
            .frame(height: 100)

            VStack(spacing: 0) {
                HStack {
                    Button(action: { dismiss() }) {
                        ZStack {
                            Circle()
                                .fill(Color.white.opacity(0.22))
                                .frame(width: 32, height: 32)
                                .background(.ultraThinMaterial, in: Circle())

                            Image(systemName: "chevron.left")
                                .font(.system(size: 14, weight: .bold))
                                .foregroundStyle(.white)
                        }
                    }
                    .buttonStyle(.plain)

                    Spacer()

                    HStack(spacing: 8) {
                        Button(action: {}) {
                            ZStack {
                                Circle()
                                    .fill(Color.white.opacity(0.22))
                                    .frame(width: 32, height: 32)
                                    .background(.ultraThinMaterial, in: Circle())

                                Image(systemName: "heart")
                                    .font(.system(size: 14))
                                    .foregroundStyle(.white)
                            }
                        }
                        .buttonStyle(.plain)

                        Button(action: {}) {
                            ZStack {
                                Circle()
                                    .fill(Color.white.opacity(0.22))
                                    .frame(width: 32, height: 32)
                                    .background(.ultraThinMaterial, in: Circle())

                                Image(systemName: "square.and.arrow.up")
                                    .font(.system(size: 14))
                                    .foregroundStyle(.white)
                            }
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(.horizontal, 16)
                .padding(.top, 4)

                Spacer()

                HStack(spacing: 6) {
                    Capsule()
                        .fill(.white)
                        .frame(width: 16, height: 6)

                    Capsule()
                        .fill(.white.opacity(0.5))
                        .frame(width: 6, height: 6)

                    Capsule()
                        .fill(.white.opacity(0.5))
                        .frame(width: 6, height: 6)
                }
                .padding(.bottom, 12)
            }
        }
    }

    private var contentSection: some View {
        VStack(spacing: 0) {
            VStack(alignment: .leading, spacing: 0) {
                productInfoHeader

                paymentMethodsSection

                Divider()
                    .padding(.vertical, 16)

                sellerSection

                descriptionSection

                Divider()
                    .padding(.vertical, 16)

                reviewsSection
            }
            .padding(.horizontal, 20)
            .padding(.top, 20)
            .padding(.bottom, 8)
        }
    }

    private var productInfoHeader: some View {
        HStack(alignment: .top, spacing: 12) {
            VStack(alignment: .leading, spacing: 4) {
                HStack(spacing: 8) {
                    if let tag = product.tag {
                        Text(tag)
                            .font(.system(size: 12, weight: .semibold))
                            .foregroundStyle(AppTheme.brandPrimary)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 2)
                            .background(AppTheme.brandSecondary)
                            .cornerRadius(8)
                    }

                    Text("Stock: 8 pares")
                        .font(.system(size: 12))
                        .foregroundStyle(AppTheme.mutedForeground)
                }

                Text(product.title)
                    .font(.system(size: 20, weight: .bold))
                    .foregroundStyle(AppTheme.foreground)
                    .tracking(-0.4)
                    .lineSpacing(1.25)
            }

            Spacer()

            VStack(alignment: .trailing, spacing: 2) {
                Text("$\(product.price)")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundStyle(AppTheme.brandPrimary)
                    .tracking(-0.5)

                Text("MXN / par")
                    .font(.system(size: 12))
                    .foregroundStyle(AppTheme.mutedForeground)
            }
        }
        .padding(.bottom, 20)
    }

    private var paymentMethodsSection: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                PaymentPill(
                    icon: "creditcard",
                    title: "Tarjeta",
                    isSelected: selectedPayment == .card
                ) {
                    selectedPayment = .card
                }

                PaymentPill(
                    icon: "banknote",
                    title: "Efectivo",
                    isSelected: selectedPayment == .cash
                ) {
                    selectedPayment = .cash
                }

                PaymentPill(
                    icon: "person.fill",
                    title: "En persona",
                    isSelected: selectedPayment == .inPerson
                ) {
                    selectedPayment = .inPerson
                }
            }
        }
        .padding(.bottom, 20)
    }

    private var sellerSection: some View {
        HStack(spacing: 12) {
            RoundedRectangle(cornerRadius: 12)
                .fill(AppTheme.input)
                .frame(width: 44, height: 44)

            VStack(alignment: .leading, spacing: 4) {
                Text("Sofía Reyes")
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundStyle(AppTheme.foreground)

                HStack(spacing: 4) {
                    HStack(spacing: 1) {
                        ForEach(0..<5, id: \.self) { _ in
                            Image(systemName: "star.fill")
                                .font(.system(size: 11))
                                .foregroundStyle(AppTheme.brandPrimary)
                        }
                    }

                    Text("4.9")
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundStyle(AppTheme.foreground)

                    Text("· IPN · 134 ventas")
                        .font(.system(size: 12))
                        .foregroundStyle(AppTheme.mutedForeground)
                }
            }

            Spacer()

            Button(action: {}) {
                Text("Ver perfil")
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundStyle(AppTheme.brandPrimary)
            }
            .buttonStyle(.plain)
        }
        .padding(.bottom, 20)
    }

    private var descriptionSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Descripción")
                .font(.system(size: 13, weight: .bold))
                .foregroundStyle(AppTheme.foreground)

            Text(product.description)
                .font(.system(size: 13))
                .foregroundStyle(AppTheme.mutedForeground)
                .lineSpacing(1.6)
        }
        .padding(.bottom, 20)
    }

    private var reviewsSection: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Text("Reseñas")
                    .font(.system(size: 13, weight: .bold))
                    .foregroundStyle(AppTheme.foreground)

                Spacer()

                HStack(spacing: 6) {
                    HStack(spacing: 1) {
                        ForEach(0..<5, id: \.self) { _ in
                            Image(systemName: "star.fill")
                                .font(.system(size: 11))
                                .foregroundStyle(AppTheme.brandPrimary)
                        }
                    }

                    Text("4.9")
                        .font(.system(size: 12, weight: .bold))
                        .foregroundStyle(AppTheme.foreground)

                    Text("(47)")
                        .font(.system(size: 12))
                        .foregroundStyle(AppTheme.mutedForeground)
                }
            }
            .padding(.bottom, 12)

            ReviewItem(
                avatar: "",
                name: "Luisa G.",
                time: "hace 2 días",
                rating: 5,
                comment: "Súper bonitos, los tejidos son muy finos. Los recomiendo totalmente 💯"
            )

            ReviewItem(
                avatar: "",
                name: "Rodrigo M.",
                time: "hace 5 días",
                rating: 4,
                comment: "Buena calidad, aunque tardaron un día más de lo esperado. Igual los volvería a comprar."
            )

            ReviewItem(
                avatar: "",
                name: "Camila T.",
                time: "hace 1 semana",
                rating: 5,
                comment: "Me encantaron los colores, exactamente como en la foto. ¡Gracias!"
            )

            Button(action: {}) {
                Text("Ver todas las reseñas")
                    .font(.system(size: 13, weight: .medium))
                    .foregroundStyle(AppTheme.mutedForeground)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(AppTheme.border, lineWidth: 1)
                    )
            }
            .buttonStyle(.plain)
            .padding(.top, 12)
        }
    }

    private var bottomActionBar: some View {
        HStack(spacing: 12) {
            Button(action: {}) {
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(AppTheme.border, lineWidth: 1)
                        .frame(width: 48, height: 48)

                    Image(systemName: "bubble.left")
                        .font(.system(size: 18))
                        .foregroundStyle(AppTheme.foreground)
                }
            }
            .buttonStyle(.plain)

            Button(action: {}) {
                Text("Comprar ahora")
                    .font(.system(size: 15, weight: .semibold))
                    .tracking(-0.1)
                    .foregroundStyle(AppTheme.brandPrimaryForeground)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 14)
                    .background(AppTheme.brandPrimary)
                    .cornerRadius(16)
                    .shadow(color: AppTheme.brandPrimary.opacity(0.3), radius: 14, x: 0, y: 4)
            }
            .buttonStyle(.plain)
        }
        .padding(.horizontal, 20)
        .padding(.top, 12)
        .padding(.bottom, 32)
        .background(AppTheme.background)
        .overlay(
            Rectangle()
                .frame(height: 1)
                .foregroundStyle(AppTheme.border),
            alignment: .top
        )
    }
}

struct PaymentPill: View {
    let icon: String
    let title: String
    let isSelected: Bool
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            HStack(spacing: 6) {
                Image(systemName: icon)
                    .font(.system(size: 12))
                    .foregroundStyle(isSelected ? AppTheme.brandPrimary : AppTheme.mutedForeground)

                Text(title)
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundStyle(isSelected ? AppTheme.brandSecondaryForeground : AppTheme.mutedForeground)
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .background(isSelected ? AppTheme.brandSecondary : AppTheme.muted)
            .cornerRadius(16)
        }
        .buttonStyle(.plain)
    }
}

struct ReviewItem: View {
    let avatar: String
    let name: String
    let time: String
    let rating: Int
    let comment: String

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            RoundedRectangle(cornerRadius: 12)
                .fill(AppTheme.input)
                .frame(width: 36, height: 36)

            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text(name)
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundStyle(AppTheme.foreground)

                    Spacer()

                    Text(time)
                        .font(.system(size: 12))
                        .foregroundStyle(AppTheme.mutedForeground)
                }

                HStack(spacing: 1) {
                    ForEach(0..<5, id: \.self) { index in
                        Image(systemName: "star.fill")
                            .font(.system(size: 11))
                            .foregroundStyle(index < rating ? AppTheme.brandPrimary : AppTheme.muted)
                    }
                }

                Text(comment)
                    .font(.system(size: 13))
                    .foregroundStyle(AppTheme.foreground)
                    .lineSpacing(1.5)
            }
        }
        .padding(.vertical, 16)
        .overlay(
            Rectangle()
                .frame(height: 1)
                .foregroundStyle(AppTheme.border),
            alignment: .bottom
        )
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}

#Preview {
    ProductDetailView(product: Product(title: "Calcetines tejidos a mano", price: 80, seller: "Sofía R.", tag: "Nuevo", description: "Calcetines tejidos a mano con estambre 100% acrílico suave."))
}
