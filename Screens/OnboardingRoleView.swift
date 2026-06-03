import SwiftUI

enum UserRole {
    case buyer
    case seller
    case both
}

struct OnboardingRoleView: View {
    @Binding var selectedRole: UserRole?
    let onContinue: () -> Void
    var onBack: (() -> Void)?

    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                headerSection

                roleCardsSection

                bothOptionSection

                Spacer()

                footerSection
            }
        }
        .background(AppTheme.background)
        .navigationBarHidden(true)
    }

    private var headerSection: some View {
        VStack(alignment: .leading, spacing: 0) {
            if let onBack = onBack {
                Button(action: onBack) {
                    HStack(spacing: 4) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 14, weight: .semibold))
                        Text("Regresar")
                            .font(.system(size: 14, weight: .medium))
                    }
                    .foregroundStyle(AppTheme.brandPrimary)
                }
                .buttonStyle(.plain)
                .padding(.bottom, 16)
            }

            HStack(alignment: .center, spacing: 8) {
                ZStack {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(AppTheme.brandPrimary)
                        .frame(width: 32, height: 32)

                    Image(systemName: "bag.fill")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundStyle(AppTheme.brandPrimaryForeground)
                }

                Text("Marketu")
                    .font(.system(size: 17, weight: .bold))
                    .foregroundStyle(AppTheme.foreground)
                    .tracking(-0.3)
            }
            .padding(.bottom, 32)

            VStack(alignment: .leading, spacing: 0) {
                Text("PASO 3 DE 3")
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundStyle(AppTheme.brandPrimary)
                    .tracking(0.8)
                    .padding(.bottom, 4)

                Text("¿Eres comprador o vendedor?")
                    .font(.system(size: 30, weight: .bold))
                    .foregroundStyle(AppTheme.foreground)
                    .tracking(-0.5)
                    .lineSpacing(1.15)
                    .padding(.bottom, 8)

                Text("Puedes cambiar esto después.")
                    .font(.system(size: 15))
                    .foregroundStyle(AppTheme.mutedForeground)
                    .lineSpacing(1.5)
            }
            .padding(.leading, -8)
        }
        .padding(.horizontal, 16)
        .padding(.top, 8)
        .padding(.bottom, 24)
    }

    private var roleCardsSection: some View {
        VStack(spacing: 12) {
            RoleCard(
                emoji: "️",
                title: "Quiero comprar",
                subtitle: "Explora productos de tu escuela",
                isSelected: selectedRole == .buyer
            ) {
                selectedRole = .buyer
            }

            RoleCard(
                emoji: "",
                title: "Quiero vender",
                subtitle: "Publica tus productos por $30 cada 2 semanas",
                isSelected: selectedRole == .seller,
                showPopularBadge: true
            ) {
                selectedRole = .seller
            }
        }
        .padding(.horizontal, 16)
        .padding(.bottom, 16)
    }

    private var bothOptionSection: some View {
        Button(action: { selectedRole = .both }) {
            HStack {
                Text("Las dos cosas 🙌")
                    .font(.system(size: 15, weight: .medium))
                    .foregroundStyle(selectedRole == .both ? AppTheme.brandPrimary : AppTheme.foreground)

                Spacer()

                if selectedRole == .both {
                    Image(systemName: "checkmark")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundStyle(AppTheme.brandPrimary)
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 14)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(
                        selectedRole == .both ? AppTheme.brandPrimary : AppTheme.border,
                        lineWidth: selectedRole == .both ? 2 : 1
                    )
            )
        }
        .buttonStyle(.plain)
        .padding(.horizontal, 16)
        .padding(.bottom, 32)
    }

    private var footerSection: some View {
        VStack(spacing: 0) {
            Button(action: onContinue) {
                HStack(spacing: 8) {
                    Text("¡Entrar a Marketu!")
                        .font(.system(size: 15, weight: .semibold))
                        .tracking(-0.1)

                    Image(systemName: "chevron.right")
                        .font(.system(size: 14, weight: .bold))
                }
                .foregroundStyle(AppTheme.brandPrimaryForeground)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 16)
                .background(AppTheme.brandPrimary)
                .cornerRadius(16)
                .shadow(color: AppTheme.brandPrimary.opacity(0.3), radius: 14, x: 0, y: 4)
            }
            .buttonStyle(.plain)
            .opacity(selectedRole == nil ? 0.5 : 1)
            .disabled(selectedRole == nil)
        }
        .padding(.horizontal, 16)
        .padding(.top, 16)
        .padding(.bottom, 60)
    }
}

struct RoleCard: View {
    let emoji: String
    let title: String
    let subtitle: String
    let isSelected: Bool
    var showPopularBadge: Bool = false
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            HStack(alignment: .top, spacing: 14) {
                Text(emoji)
                    .font(.system(size: 32))

                VStack(alignment: .leading, spacing: 4) {
                    HStack(spacing: 8) {
                        Text(title)
                            .font(.system(size: 17, weight: .semibold))
                            .foregroundStyle(isSelected ? AppTheme.brandPrimary : AppTheme.foreground)

                        if showPopularBadge {
                            Text("MÁS POPULAR")
                                .font(.system(size: 10, weight: .bold))
                                .foregroundStyle(AppTheme.brandPrimary)
                                .padding(.horizontal, 6)
                                .padding(.vertical, 2)
                                .background(AppTheme.brandSecondary)
                                .cornerRadius(4)
                        }
                    }

                    Text(subtitle)
                        .font(.system(size: 13))
                        .foregroundStyle(AppTheme.mutedForeground)
                }

                Spacer()

                if isSelected {
                    Image(systemName: "checkmark")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundStyle(AppTheme.brandPrimary)
                }
            }
            .padding(16)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(isSelected ? AppTheme.brandSecondary.opacity(0.3) : AppTheme.card)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(isSelected ? AppTheme.brandPrimary : AppTheme.border, lineWidth: isSelected ? 2 : 1)
            )
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    OnboardingRoleView(selectedRole: .constant(nil), onContinue: {}, onBack: {})
}
