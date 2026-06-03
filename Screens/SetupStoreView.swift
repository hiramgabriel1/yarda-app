import SwiftUI

struct SetupStoreView: View {
    @State private var storeName = ""
    @State private var selectedCategory: String?
    @State private var description = ""
    @State private var deliveryMethod: DeliveryMethod?
    @State private var showCategorySheet = false
    @State private var showImagePicker = false

    let onContinue: () -> Void
    var onBack: (() -> Void)?

    let categories = [
        (emoji: "🍕", name: "Comida"),
        (emoji: "👕", name: "Ropa"),
        (emoji: "🎨", name: "Manualidades"),
        (emoji: "📚", name: "Servicios"),
        (emoji: "📦", name: "Otros"),
    ]

    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                headerSection

                photoPickerSection

                formFieldsSection

                deliverySection

                Spacer()

                footerSection
            }
        }
        .background(AppTheme.background)
        .navigationBarHidden(true)
        .sheet(isPresented: $showCategorySheet) {
            CategoryPickerSheet(
                categories: categories,
                selectedCategory: $selectedCategory,
                onDismiss: { showCategorySheet = false }
            )
        }
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
                Text("Arma tu tienda 🏪")
                    .font(.system(size: 30, weight: .bold))
                    .foregroundStyle(AppTheme.foreground)
                    .tracking(-0.5)
                    .lineSpacing(1.15)
                    .padding(.bottom, 8)

                Text("Así te verán los compradores de tu escuela.")
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

    private var photoPickerSection: some View {
        VStack(spacing: 8) {
            Button(action: { showImagePicker = true }) {
                ZStack {
                    Circle()
                        .strokeBorder(style: StrokeStyle(lineWidth: 2, dash: [6, 4]))
                        .foregroundStyle(AppTheme.brandPrimary)
                        .frame(width: 96, height: 96)

                    VStack(spacing: 4) {
                        Image(systemName: "camera.fill")
                            .font(.system(size: 24, weight: .medium))
                            .foregroundStyle(AppTheme.brandPrimary)

                        Text("Agregar foto")
                            .font(.system(size: 12, weight: .medium))
                            .foregroundStyle(AppTheme.brandPrimary)
                    }
                }
            }
            .buttonStyle(.plain)

            Text("Logo o foto de tu tienda")
                .font(.system(size: 13))
                .foregroundStyle(AppTheme.mutedForeground)
        }
        .padding(.bottom, 24)
    }

    private var formFieldsSection: some View {
        VStack(spacing: 12) {
            StoreTextField(
                label: "Nombre de tu tienda",
                placeholder: "Ej. Tacos de Ana, Ropa de Lupita",
                text: $storeName
            )

            VStack(alignment: .leading, spacing: 8) {
                Text("¿Qué vendes?")
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundStyle(AppTheme.foreground)

                Button(action: { showCategorySheet = true }) {
                    HStack {
                        if let category = selectedCategory {
                            Text(category)
                                .font(.system(size: 15))
                                .foregroundStyle(AppTheme.foreground)
                        } else {
                            Text("Selecciona una categoría")
                                .font(.system(size: 15))
                                .foregroundStyle(AppTheme.mutedForeground)
                        }

                        Spacer()

                        Image(systemName: "chevron.down")
                            .font(.system(size: 12, weight: .medium))
                            .foregroundStyle(AppTheme.mutedForeground)
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 14)
                    .background(AppTheme.input)
                    .cornerRadius(12)
                }
                .buttonStyle(.plain)
            }

            StoreTextField(
                label: "Descripción",
                placeholder: "Ej. Vendo enchiladas los martes en el edificio 3, acepto pedidos por aquí",
                text: $description,
                isMultiline: true
            )
        }
        .padding(.horizontal, 16)
        .padding(.bottom, 24)
    }

    private var deliverySection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("¿Cómo entregas?")
                .font(.system(size: 13, weight: .semibold))
                .foregroundStyle(AppTheme.foreground)

            HStack(spacing: 12) {
                DeliveryPill(
                    title: "En persona",
                    isSelected: deliveryMethod == .inPerson
                ) {
                    deliveryMethod = .inPerson
                }

                DeliveryPill(
                    title: "A domicilio en campus",
                    isSelected: deliveryMethod == .delivery
                ) {
                    deliveryMethod = .delivery
                }
            }
        }
        .padding(.horizontal, 16)
        .padding(.bottom, 32)
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
                .foregroundStyle(AppTheme.brandPrimaryForeground)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 16)
                .background(AppTheme.brandPrimary)
                .cornerRadius(16)
                .shadow(color: AppTheme.brandPrimary.opacity(0.3), radius: 14, x: 0, y: 4)
            }
            .buttonStyle(.plain)

            Text("Siguiente: activa tu plan vendedor")
                .font(.system(size: 12))
                .foregroundStyle(AppTheme.mutedForeground)
                .padding(.top, 12)
        }
        .padding(.horizontal, 16)
        .padding(.top, 16)
        .padding(.bottom, 60)
    }
}

enum DeliveryMethod {
    case inPerson
    case delivery
}

struct StoreTextField: View {
    let label: String
    let placeholder: String
    @Binding var text: String
    var isMultiline: Bool = false

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(label)
                .font(.system(size: 13, weight: .semibold))
                .foregroundStyle(AppTheme.foreground)

            if isMultiline {
                TextEditor(text: $text)
                    .font(.system(size: 15))
                    .foregroundStyle(AppTheme.foreground)
                    .padding(12)
                    .background(AppTheme.input)
                    .cornerRadius(12)
                    .frame(minHeight: 80)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(AppTheme.input, lineWidth: 1)
                    )
            } else {
                TextField(placeholder, text: $text)
                    .font(.system(size: 15))
                    .foregroundStyle(AppTheme.foreground)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 14)
                    .background(AppTheme.input)
                    .cornerRadius(12)
            }
        }
    }
}

struct DeliveryPill: View {
    let title: String
    let isSelected: Bool
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            Text(title)
                .font(.system(size: 14, weight: .medium))
                .foregroundStyle(isSelected ? AppTheme.brandPrimaryForeground : AppTheme.foreground)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 12)
                .background(isSelected ? AppTheme.brandPrimary : AppTheme.input)
                .cornerRadius(12)
        }
        .buttonStyle(.plain)
    }
}

struct CategoryPickerSheet: View {
    let categories: [(emoji: String, name: String)]
    @Binding var selectedCategory: String?
    let onDismiss: () -> Void

    var body: some View {
        NavigationStack {
            List {
                ForEach(categories, id: \.name) { category in
                    Button(action: {
                        selectedCategory = "\(category.emoji) \(category.name)"
                        onDismiss()
                    }) {
                        HStack {
                            Text(category.emoji)
                                .font(.system(size: 24))
                            Text(category.name)
                                .font(.system(size: 16))
                                .foregroundStyle(AppTheme.foreground)

                            Spacer()

                            if selectedCategory == "\(category.emoji) \(category.name)" {
                                Image(systemName: "checkmark")
                                    .foregroundStyle(AppTheme.brandPrimary)
                            }
                        }
                    }
                }
            }
            .listStyle(.insetGrouped)
            .navigationTitle("¿Qué vendes?")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancelar") {
                        onDismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    SetupStoreView(onContinue: {}, onBack: {})
}
