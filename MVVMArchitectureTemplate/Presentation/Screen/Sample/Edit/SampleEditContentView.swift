import Combine
import SnapKit
import UIKit

// MARK: - stored properties & init

final class SampleEditContentView: UIView {
    private(set) lazy var didChangeTitleTextPublisher = titleTextField.textDidChangePublisher
    private(set) lazy var didChangeBodyTextPublisher = bodyTextField.textDidChangePublisher
    private(set) lazy var didTapEditButtonPublisher = editButton.publisher(for: .touchUpInside)

    private lazy var stackView: UIStackView = {
        $0.axis = .vertical
        $0.spacing = 32
        return $0
    }(UIStackView(arrangedSubviews: [
        userIdLabel,
        titleTextField,
        bodyTextField,
        buttonStackView
    ]))

    private lazy var buttonStackView: UIStackView = {
        $0.axis = .vertical
        $0.alignment = .center
        return $0
    }(UIStackView(arrangedSubviews: [editButton]))

    private let userIdLabel = UILabel(
        styles: [.italic16]
    )

    private let titleTextField = UITextField(
        styles: [
            .PlaceHolder.title,
            .round,
            .borderPrimary,
            .cornerRadius8
        ]
    )

    private let bodyTextField = UITextField(
        styles: [
            .PlaceHolder.body,
            .round,
            .borderPrimary,
            .cornerRadius8
        ]
    )

    private let editButton = UIButton(
        styles: [
            .ButtonTitle.edit,
            .titlePrimary,
            .borderPrimary,
            .cornerRadius8
        ]
    )

    private let modelObject: SampleModelObject

    init(modelObject: SampleModelObject) {
        self.modelObject = modelObject

        super.init(frame: .zero)

        setupViews()
        setupConstraints()
        setupConfigure(modelObject: modelObject)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
            super.traitCollectionDidChange(previousTraitCollection)

            [titleTextField, bodyTextField].forEach {
                $0.apply(.borderPrimary)
            }

            editButton.layer.borderColor = enableColor(isEnabled: editButton.isEnabled).cgColor
        }
    }
}

// MARK: - internal methods

extension SampleEditContentView {
    func buttonEnabled(_ isEnabled: Bool) {
        editButton.isEnabled = isEnabled
        editButton.layer.borderColor = enableColor(isEnabled: isEnabled).cgColor
        editButton.setTitleColor(enableColor(isEnabled: isEnabled), for: .normal)
    }
}

// MARK: - private methods

private extension SampleEditContentView {
    func setupConfigure(modelObject: SampleModelObject) {
        userIdLabel.text = "UserID: \(modelObject.userId)"
        titleTextField.text = modelObject.title
        bodyTextField.text = modelObject.body
    }

    func enableColor(isEnabled: Bool) -> UIColor {
        isEnabled
            ? .dynamicColor(light: .black, dark: .white)
            : .dynamicColor(light: .black, dark: .white).withAlphaComponent(0.3)
    }
}

// MARK: - protocol

extension SampleEditContentView: ContentView {
    func setupViews() {
        apply(.background)
        addSubview(stackView)
    }

    func setupConstraints() {
        stackView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(32)
        }

        [titleTextField, bodyTextField].forEach {
            $0.snp.makeConstraints {
                $0.height.equalTo(48)
            }
        }

        editButton.snp.makeConstraints {
            $0.width.equalTo(160)
            $0.height.equalTo(56)
        }
    }
}

// MARK: - preview

#if DEBUG
    import SwiftUI

    struct SampleEditContentViewPreview: PreviewProvider {
        static var previews: some View {
            WrapperView(
                view: SampleEditContentView(
                    modelObject: SampleModelObjectBuilder().build()
                )
            )
        }
    }
#endif
