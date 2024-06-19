import UIKit

class PostComposeViewController: UIViewController {
    var onSave: ((Post) -> Void)?
    
    var EMButton: UIButton!
    var NMButton: UIButton!
    var ETCButton: UIButton!
    
    var btnArray = [UIButton]()
    var selectedPriority: String = "Normal" // 기본 우선순위 값 설정
    
    private let titleField: UITextField = {
        let textField = UITextField()
        textField.placeholder = " Title"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = UIFont(name: "Futura", size: 15)
        textField.textColor = UIColor.black
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.borderWidth = 5.0
        textField.layer.cornerRadius = 5.0
        return textField
    }()
    
    private let dateField: UITextField = {
        let textField = UITextField()
        textField.placeholder = " Date"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = UIFont(name: "Futura", size: 15)
        textField.textColor = UIColor.black
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.borderWidth = 5.0
        textField.layer.cornerRadius = 5.0
        return textField
    }()
    
    private let authorField: UITextField = {
        let textField = UITextField()
        textField.placeholder = " Author"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = UIFont(name: "Futura", size: 15)
        textField.textColor = UIColor.black
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.borderWidth = 5.0
        textField.layer.cornerRadius = 5.0
        return textField
    }()
    
    private let contentField: UITextView = {
        let textView = UITextView()
        textView.layer.borderColor = UIColor.black.cgColor
        textView.layer.borderWidth = 5.0
        textView.layer.cornerRadius = 5.0
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont(name: "Futura", size: 18)
        textView.textColor = UIColor.black
        return textView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Create New Post"
        view.backgroundColor = .white
        
        let saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(savePost))
        navigationItem.rightBarButtonItem = saveButton
        
        view.addSubview(titleField)
        view.addSubview(dateField)
        view.addSubview(authorField)
        view.addSubview(contentField)
        
        setupDatePicker()
        
        NSLayoutConstraint.activate([
            titleField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            titleField.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            
            dateField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            dateField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            dateField.topAnchor.constraint(equalTo: titleField.bottomAnchor, constant: 16),
            
            authorField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            authorField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            authorField.topAnchor.constraint(equalTo: dateField.bottomAnchor, constant: 16),
            
            contentField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            contentField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            contentField.topAnchor.constraint(equalTo: authorField.bottomAnchor, constant: 50),
            contentField.heightAnchor.constraint(equalToConstant: 500)
        ])
        
        // 급한 정도 체크
        EMButton = UIButton(type: .system)
        EMButton.setTitle("Urgent", for: .normal)
        EMButton.frame = CGRect(x: 15, y: 245, width: 100, height: 30)
        EMButton.layer.borderWidth = 5.0
        EMButton.layer.borderColor = UIColor.black.cgColor
        EMButton.setTitleColor(UIColor.black, for: .normal)
        EMButton.titleLabel?.font = UIFont(name: "Futura", size: 15)
        EMButton.addTarget(self, action: #selector(selectOptionBtnAction(_:)), for: .touchUpInside)
        view.addSubview(EMButton)
        
        NMButton = UIButton(type: .system)
        NMButton.setTitle("Important", for: .normal)
        NMButton.frame = CGRect(x: 145, y: 245, width: 100, height: 30)
        NMButton.layer.borderWidth = 5.0
        NMButton.layer.borderColor = UIColor.black.cgColor
        NMButton.setTitleColor(UIColor.black, for: .normal)
        NMButton.titleLabel?.font = UIFont(name: "Futura", size: 15)
        NMButton.addTarget(self, action: #selector(selectOptionBtnAction(_:)), for: .touchUpInside)
        view.addSubview(NMButton)
        
        ETCButton = UIButton(type: .system)
        ETCButton.setTitle("Reference", for: .normal)
        ETCButton.frame = CGRect(x: 275, y: 245, width: 100, height: 30)
        ETCButton.layer.borderWidth = 5.0
        ETCButton.layer.borderColor = UIColor.black.cgColor
        ETCButton.setTitleColor(UIColor.black, for: .normal)
        ETCButton.titleLabel?.font = UIFont(name: "Futura", size: 15)
        ETCButton.addTarget(self, action: #selector(selectOptionBtnAction(_:)), for: .touchUpInside)
        view.addSubview(ETCButton)
        
        btnArray.append(EMButton)
        btnArray.append(NMButton)
        btnArray.append(ETCButton)
    }
    
    private func setupDatePicker() {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.addTarget(self, action: #selector(dateChanged(_:)), for: .valueChanged)
        
        dateField.inputView = datePicker
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(donePressed))
        toolbar.setItems([doneButton], animated: true)
        
        dateField.inputAccessoryView = toolbar
    }
    
    @objc private func dateChanged(_ sender: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        dateField.text = formatter.string(from: sender.date)
    }
    
    @objc private func donePressed() {
        view.endEditing(true)
    }
    
    @objc func selectOptionBtnAction(_ sender: UIButton) {
        for btn in btnArray {
            if (btn == sender) {
                btn.isSelected = true
                btn.backgroundColor = UIColor.red
                selectedPriority = btn.currentTitle ?? "Important" // 선택된 우선순위를 설정
            } else {
                btn.isSelected = false
                btn.backgroundColor = UIColor.gray
            }
        }
    }
    
    @objc private func savePost() {
        guard let title = titleField.text, !title.isEmpty,
              let date = dateField.text, !date.isEmpty,
              let author = authorField.text, !author.isEmpty,
              let content = contentField.text, !content.isEmpty else {
            // Alert for empty title, date, author, or content
            let alert = UIAlertController(title: "Error", message: "Title, Date, Author, and Content cannot be empty.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }
        
        let newPost = Post(title: title, date: date, author: author, content: content, priority: selectedPriority)
        onSave?(newPost)
        navigationController?.popViewController(animated: true)
    }
}

