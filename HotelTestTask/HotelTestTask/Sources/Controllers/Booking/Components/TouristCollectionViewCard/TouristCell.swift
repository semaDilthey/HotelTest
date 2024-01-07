import Foundation
import UIKit
import SnapKit
import CocoaTextField

final class TouristCell : UICollectionViewCell {
    
    static let identifier = "TouristCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()

        arrayTextFileds().map { $0.delegate = self }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var isSelected: Bool {
        didSet {
           updateAppearance()
        }
    }
    // Вызывается в момент, когда все текстфилды были заполнены в методе configureTextFiled
    public var didFilledTourist : ((TouristModelProtocol)->())?
    // локальный объект туриста в ячейке
    private var tourist : TouristModelProtocol = TouristModel()
        
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
    private var expandedConstraint : Constraint!
    
    // констрейнт для сжатого состояния
    private var collapsedConstraint : Constraint!
    
    private lazy var mainContainter = UIView()
    private lazy var topContrainer = UIView()
    private lazy var bottomContrainer = UIView()

    private let title : UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()

    private lazy var expandButton : UIButton = {
        let expandButton = UIButton(type: .custom)
        expandButton.translatesAutoresizingMaskIntoConstraints = false
        expandButton.setImage(UIImage(named: "nonExpandedIcon"), for: .normal)
        expandButton.backgroundColor = UIColor.SD.blueLight
        expandButton.layer.cornerRadius = 6
    
        return expandButton
    }()
    
    private lazy var nameField = CocoaTextField.create(placeholder: "Имя")
    private lazy var surnameField = CocoaTextField.create(placeholder: "Фамилия")
    private lazy var birthdayFiled = CocoaTextField.create(placeholder: "Дата рождения")
    private lazy var citizenshipField = CocoaTextField.create(placeholder: "Гражданство")
    private lazy var passportNumberField = CocoaTextField.create(placeholder: "Номер загранпаспорта")
    private lazy var passportValidationField = CocoaTextField.create(placeholder: "Срок действия загранпаспорта")
    
    public func arrayTextFileds() -> [CocoaTextField] {
        var array : [CocoaTextField] = []
        array.append(nameField)
        array.append(surnameField)
        array.append(birthdayFiled)
        array.append(citizenshipField)
        array.append(passportNumberField)
        array.append(passportValidationField)
        return array
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
    
    // обновляет внешний вид в зависимости от состояния ячейки (свернуто/развернуто)
    private func updateAppearance() {
        collapsedConstraint.isActive = !isSelected
        expandedConstraint.isActive = isSelected
        // разворот кнопки-галочки
        UIView.animate(withDuration: 0.3) {
            let upsideDown = CGAffineTransform(rotationAngle: .pi * -0.999)
            self.expandButton.imageView?.transform = self.isSelected ? upsideDown : .identity
        }

        if expandedConstraint.isActive {
            UIView.animate(withDuration: 0.25, animations: {
                // Уменьшаем размер ячейки
                self.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            }) { _ in 
                // Восстанавливаем размер ячейки после завершения анимации
                UIView.animate(withDuration: 0.25) {
                    self.transform = CGAffineTransform.identity
                }
            }
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

//MARK: -  UITextFieldDelegate
extension TouristCell : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case nameField, surnameField, birthdayFiled, citizenshipField, passportNumberField, passportValidationField:
            configureTouristModel(byTextFields: [nameField, surnameField, birthdayFiled, citizenshipField, passportNumberField, passportValidationField])
            textField.resignFirstResponder()
            return true
        default: 
            return false
        }
    }
}

//MARK:  Конфигуригуем модель от текситфилда
extension TouristCell {
    
    private func configureTouristModel(byTextFields: [CocoaTextField]) {

            for field in byTextFields {
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
        
        if tourist.isFullyFilled() {
            didFilledTourist?(tourist)
        }
    }
}

