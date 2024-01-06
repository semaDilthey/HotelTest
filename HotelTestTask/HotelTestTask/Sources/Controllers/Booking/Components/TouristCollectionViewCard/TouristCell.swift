import Foundation
import UIKit
import SnapKit
import CocoaTextField


final class TouristCell : UICollectionViewCell {
    
    static let identifier = "TouristCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var isSelected: Bool {
        didSet {
           updateAppearance()
        }
    }
    
    var updateTourist : ((TouristModelProtocol)->())?
    var tourist : TouristModelProtocol = TouristModel()
    var buttonCallback : (()->())?
    
    func configureTitle(for indexPath: IndexPath) {
        switch indexPath.row {
        case 0 : title.text = "Первый турист"
        case 1 : title.text = "Второй турист"
        case 2 : title.text = "Третий турист"
        case 3 : title.text = "Четвертый турист"
        default : title.text = "Лишний турист"
        }
    }
    
    // констрейнт для открытого состояния
    var expandedConstraint : Constraint!
    
    // констрейнт для сжатого состояния
    var collapsedConstraint : Constraint!
    
    private lazy var mainContainter = UIView()
    private lazy var topContrainer = UIView()
    private lazy var bottomContrainer = UIView()

    let title : UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()

    lazy var expandButton : UIButton = {
        let expandButton = UIButton(type: .custom)
        expandButton.translatesAutoresizingMaskIntoConstraints = false
        expandButton.setImage(UIImage(named: "nonExpandedIcon"), for: .normal)
        expandButton.backgroundColor = UIColor.SD.blueLight
        expandButton.layer.cornerRadius = 6
        expandButton.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
    
        return expandButton
    }()
    
    lazy var nameField = createTextFiled(with: "Имя")
    lazy var surnameField = createTextFiled(with: "Фамилия")
    lazy var birthdayFiled = createTextFiled(with: "Дата рождения")
    lazy var citizenshipField = createTextFiled(with: "Гражданство")
    lazy var passportNumberField = createTextFiled(with: "Номер загранпаспорта")
    lazy var passportValidationField = createTextFiled(with: "Срок действия загранпаспорта")
    
    private func getTextFields() -> [CocoaTextField] {
        var array : [CocoaTextField] = []
        array.append(nameField)
        array.append(surnameField)
        array.append(birthdayFiled)
        array.append(citizenshipField)
        array.append(passportNumberField)
        array.append(passportValidationField)
        return array
    }
    
    @objc func buttonClicked() {
        buttonCallback?()
    }
    
}
//MARK: - Setup UI
extension TouristCell {
    
    private func configureView() {
        contentView.layer.cornerRadius = 12
        contentView.clipsToBounds = true

        topContrainer.backgroundColor = .white
        bottomContrainer.backgroundColor = .white
        
        makeConstaints()
        updateAppearance()
    }
    
    private func updateAppearance() {
        collapsedConstraint.isActive = !isSelected
        expandedConstraint.isActive = isSelected
        
        UIView.animate(withDuration: 0.3) {
            let upsideDown = CGAffineTransform(rotationAngle: .pi * -0.999)
            self.expandButton.imageView?.transform = self.isSelected ? upsideDown : .identity
        }
    }
    
    private func makeConstaints() {
        
        contentView.addSubview(mainContainter)
        mainContainter.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        mainContainter.addSubview(topContrainer)
        topContrainer.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(54)
        }
        
        // Констрейнты для сжатого состояния (низ ячейки совпадает с низом верхнего контейнера)
        topContrainer.snp.prepareConstraints { make in
            collapsedConstraint = make.bottom.equalToSuperview().constraint
            collapsedConstraint.layoutConstraints.first?.priority = .defaultLow
        }
        
        topContrainer.addSubview(expandButton)
        expandButton.snp.makeConstraints { make in
            make.height.equalTo(32)
            make.width.equalTo(32)
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-16)
        }
        
        topContrainer.addSubview(title)
        title.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(16)
        }
        
        
        mainContainter.addSubview(bottomContrainer)
        bottomContrainer.snp.makeConstraints { make in
            make.top.equalTo(topContrainer.snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(410)
        }
        
        // Констрейнты для открытого состояния (низ ячейки совпадает с низом нижнего контейнера)
        bottomContrainer.snp.prepareConstraints { make in
            expandedConstraint = make.bottom.equalToSuperview().constraint
            expandedConstraint.layoutConstraints.first?.priority = .defaultLow
        }
        
        /// Стак для текстФилдов
        #warning("TODO: Прокидку во вью модель. Валидацию по полю Имени и Фамилии")
        let fieldsStack = UIStackView(arrangedSubviews: [nameField, surnameField, birthdayFiled, citizenshipField, passportNumberField, passportValidationField])
        fieldsStack.translatesAutoresizingMaskIntoConstraints = false
        fieldsStack.spacing = 8
        fieldsStack.axis = .vertical
        fieldsStack.distribution = .fillEqually
        for textField in fieldsStack.arrangedSubviews {
            textField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        }
        
        mainContainter.addSubview(fieldsStack)
        fieldsStack.snp.makeConstraints { make in
            make.top.equalTo(bottomContrainer.snp.top)
            make.left.equalToSuperview().offset(16)
            make.right.equalTo(-16)
        }
    }
}


extension TouristCell {
    
    private func createTextFiled(with placeholder: String) -> CocoaTextField {
        let textField = CocoaTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderColor = .clear
        textField.defaultBackgroundColor = UIColor.SD.greyLight!
        textField.focusedBackgroundColor = UIColor.SD.greyLight!
        textField.placeholder = placeholder
        textField.font = UIFont.SD.proDisplayFont(size: 16, weight: .thin)
        textField.activeHintColor = UIColor.SD.grey!
        textField.delegate = self
        return textField
    }
    
}

extension TouristCell : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case nameField, surnameField, birthdayFiled, citizenshipField, passportNumberField, passportValidationField:
            configureTextFiled(textFields: [nameField, surnameField, birthdayFiled, citizenshipField, passportNumberField, passportValidationField])
            textField.resignFirstResponder()
            return true
        default: 
            return false
        }
    }
}


extension TouristCell {
    
    private func configureTextFiled(textFields: [CocoaTextField]) {

            for field in textFields {
                if field.isEditing {
                    field.resignFirstResponder()

                    if let text = field.text, !text.isEmpty {
                        field.borderColor = .clear

                        switch field {
                        case nameField:
                            tourist.name = text
                        case surnameField:
                            tourist.surname = text
                        case birthdayFiled:
                            // Предполагаем, что birthdayFiled содержит дату
                            tourist.birthday = Date()
                        case citizenshipField:
                            tourist.nationality = text
                        case passportNumberField:
                            tourist.passportID = text
                        case passportValidationField:
                            // Предполагаем, что passportValidationField содержит срок действия паспорта
                            tourist.passportValidity = Date()
                        default:
                            break
                        }
                    } else {
                        field.borderColor = .red
                        field.text = ""
                        field.activeHintColor = .red
                    }
                }
            }
        print("tourist in cell \(tourist)")
        updateTourist?(tourist)
    }
}


