import SwiftUI

struct OnboardingNameView: View {
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var showImagePicker = false
    let onContinue: () -> Void
    var onBack: (() -> Void)?

    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                headerSection

                nameFieldsSection

                photoPickerSection

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
                    .foregroundStyle(AppTheme.primary)
                }
                .buttonStyle(.plain)
                .padding(.bottom, 16)
            }

            HStack(alignment: .center, spacing: 8) {
                ZStack {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(AppTheme.primary)
                        .frame(width: 32, height: 32)

                    Image(systemName: "bag.fill")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundStyle(AppTheme.primaryForeground)
                }

                Text("Marketu")
                    .font(.system(size: 17, weight: .bold))
                    .foregroundStyle(AppTheme.foreground)
                    .tracking(-0.3)
            }
            .padding(.bottom, 32)

            VStack(alignment: .leading, spacing: 0) {
                Text("PASO 2 DE 3")
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundStyle(AppTheme.primary)
                    .tracking(0.8)
                    .padding(.bottom, 4)

                Text("¿Cómo te llamas?")
                    .font(.system(size: 30, weight: .bold))
                    .foregroundStyle(AppTheme.foreground)
                    .tracking(-0.5)
                    .lineSpacing(1.15)
                    .padding(.bottom, 8)

                Text("Así te verán los demás en Marketu.")
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

    private var nameFieldsSection: some View {
        VStack(spacing: 12) {
            CustomTextField(placeholder: "Nombre", text: $firstName)
            CustomTextField(placeholder: "Apellido", text: $lastName)
        }
        .padding(.horizontal, 16)
        .padding(.bottom, 32)
    }

    private var photoPickerSection: some View {
        VStack(spacing: 16) {
            Button(action: { showImagePicker = true }) {
                ZStack {
                    Circle()
                        .strokeBorder(style: StrokeStyle(lineWidth: 2, dash: [6, 4]))
                        .foregroundStyle(AppTheme.primary)
                        .frame(width: 96, height: 96)

                    VStack(spacing: 4) {
                        Image(systemName: "camera.fill")
                            .font(.system(size: 24, weight: .medium))
                            .foregroundStyle(AppTheme.primary)

                        Text("Agregar foto")
                            .font(.system(size: 12, weight: .medium))
                            .foregroundStyle(AppTheme.primary)
                    }
                }
            }
            .buttonStyle(.plain)

            Text("Tu foto ayuda a generar confianza con compradores y vendedores.")
                .font(.system(size: 13))
                .foregroundStyle(AppTheme.mutedForeground)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 32)
        }
        .padding(.horizontal, 16)
        .padding(.bottom, 24)
    }

    private var footerSection: some View {
        VStack(spacing: 0) {
            Button(action: onContinue) {
                HStack(spacing: 8) {
                    Text("Continuar")
                        .font(.system(size: 15, weight: .semibold))
                        .tracking(-0.1)

                    Image(systemName: "chevron.right")
                        .font(.system(size: 14, weight: .bold))
                }
                .foregroundStyle(AppTheme.primaryForeground)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 16)
                .background(AppTheme.primary)
                .cornerRadius(16)
                .shadow(color: AppTheme.primary.opacity(0.3), radius: 14, x: 0, y: 4)
            }
            .buttonStyle(.plain)

            HStack(spacing: 0) {
                Text("¿Algo más? ")
                    .font(.system(size: 12))
                    .foregroundStyle(AppTheme.mutedForeground)

                Text("Sugiérela aquí")
                    .font(.system(size: 12, weight: .medium))
                    .foregroundStyle(AppTheme.primary)
            }
            .padding(.top, 12)
        }
        .padding(.horizontal, 16)
        .padding(.top, 16)
        .padding(.bottom, 60)
    }
}

struct CustomTextField: View {
    let placeholder: String
    @Binding var text: String

    var body: some View {
        TextField(placeholder, text: $text)
            .font(.system(size: 15))
            .foregroundStyle(AppTheme.foreground)
            .padding(.horizontal, 16)
            .padding(.vertical, 14)
            .background(AppTheme.input)
            .cornerRadius(12)
    }
}

#Preview {
    OnboardingNameView(onContinue: {}, onBack: {})
}
