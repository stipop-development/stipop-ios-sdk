//
//  SPDChatroomViewController.swift
//  Stipop Demo
//
//  Created by Jay Ahn on 2021/10/12.
//

import UIKit
import Stipop

class SPDChatroomViewController: UIViewController {
    
    @IBOutlet weak var navigationTitleView: UIView!
    @IBOutlet weak var moreButton: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var stipopPickerButton: SPUIButton!
    @IBOutlet weak var messageField: UITextField!
    @IBOutlet weak var messageFieldBubble: UIView!
    @IBOutlet weak var messageFieldBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var messageSendButton: UIButton!
    @IBOutlet weak var pickerViewPositionView: UIView!
    
    var user: SPUser = SPUser(userID: "-1")
    
    @IBAction func messageSend(_ sender: Any) {
        if let text = messageField.text {
            appendChat(.text(.me, text))
            messageField.text = ""
            messageFieldDidChange(messageField)
        }
    }
    
    fileprivate var chattings: [SPDChatModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        messageSendButton.isEnabled = false
        configureUI()
        
        configureStipopButton()
//        setupSearchVC()
//        setupPickerVC()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        messageFieldBubble.layer.borderColor = UIColor(named: ColorEnum.StipopTextFieldBackgroundStroke)?.cgColor
    }
}

extension SPDChatroomViewController {
    
    private func configureUI(){
        configureNavigationBar()
        configureTableView()
        configureMoreButton()
        configureMessageFields()
        
        makeInitialBubbles()
        
        func configureNavigationBar(){
            let navigationBarTopView = UIView()
            navigationBarTopView.backgroundColor = UIColor(named: ColorEnum.StipopMain)
            
            view.addSubview(navigationBarTopView)
            
            let safeAreaTopInset = UIApplication.shared.windows[0].safeAreaInsets.top
            
            navigationBarTopView.translatesAutoresizingMaskIntoConstraints = false
            navigationBarTopView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
            navigationBarTopView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
            navigationBarTopView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
            navigationBarTopView.heightAnchor.constraint(equalToConstant: safeAreaTopInset).isActive = true
        }
        func configureTableView() {
            tableView.dataSource = self
            tableView.rowHeight = UITableView.automaticDimension
        }
        
        func configureMoreButton() {
            if #available(iOS 15.0, *) {
                let barButtonMenu = UIMenu(title: "", children: [
                    UIAction(title: "Contact us", handler: { [weak self] action in
                        self?.contactUs(action: action)
                    }),
                    UIAction(title: "Go to github", handler: { [weak self] action in
                        self?.goToGithub(action: action)
                    })
                ])
                moreButton.menu = barButtonMenu
            }
        }
        
        func configureMessageFields() {
            messageField.addTarget(self, action: #selector(messageFieldDidChange(_:)), for: .editingChanged)
            
            NotificationCenter.default.addObserver(self,
                                                   selector: #selector(self.keyboardWillShow(_:)),
                                                   name: UIResponder.keyboardWillShowNotification,
                                                   object: nil)
            NotificationCenter.default.addObserver(self,
                                                   selector: #selector(self.keyboardWillHide(_:)),
                                                   name: UIResponder.keyboardWillHideNotification,
                                                   object: nil)
        }
        
        func makeInitialBubbles(){
            appendChat(.text(.counter, "Hi, there!👋"))
            appendChat(.sticker(.counter, "https://img.stipop.io/2020/3/31/1585719674256_CookieArrow_size.gif"))
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
                self?.appendChat(.text(.counter, "Welcome to Stipop SDK!\nPress the button below to get started."))
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
                self?.appendChat(.execution(.counter, "Try the sticker feature. 🔽", {
                    self?.stipopPickerButton.sendActions(for: .touchUpInside)
                }))
            }
        }
    }
    
    @available(iOS 13.0, *)
    func contactUs(action: UIAction) {
        guard let url = URL(string: "https://developers.stipop.io/contact-us") else { return }
        UIApplication.shared.open(url)
    }
    @available(iOS 13.0, *)
    func goToGithub(action: UIAction? = nil) {
        guard let url = URL(string: "https://github.com/stipop-development/stipop-ios-sdk") else { return }
        UIApplication.shared.open(url)
    }
    
    @objc func keyboardWillShow(_ notification: NSNotification) {
        if let userInfo = notification.userInfo,
           let keyboardRectangle = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
            self.messageFieldBottomConstraint.priority = UILayoutPriority(1000)
            self.messageFieldBottomConstraint.constant = keyboardRectangle.height
        }
    }
    @objc func keyboardWillHide(_ notification: NSNotification) {
        self.messageFieldBottomConstraint.priority = UILayoutPriority(1)
        self.messageFieldBottomConstraint.constant = 0
    }
    @objc func messageFieldDidChange(_ textField: UITextField) {
        if let text = messageField.text,
           text != "" {
            messageSendButton.isEnabled = true
        } else {
            messageSendButton.isEnabled = false
        }
    }
    
    func configureStipopButton() {
        stipopPickerButton.setUser(user, viewType: .picker)
        stipopPickerButton.delegate = self
        
    }
    
    func appendChat(_ chat: SPDChatModel) {
        chattings.append(chat)
        tableView.insertRows(at: [IndexPath(row: chattings.count-1, section: 1)], with: .right)
        scrollChatToBottom()
    }
    
    func scrollChatToBottom() {
        let indexPath = IndexPath(row: self.chattings.count-1, section: 1)
        DispatchQueue.main.async {
            self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }
    }
    
    func setupSearchVC(){
        let searchVc = SPUISearchViewController()
        searchVc.view.backgroundColor = .white
        searchVc.setUser(user)
        searchVc.delegate = self
        
        //        self.present(searchVc, animated: true)
        if let searchView = searchVc.view {
            self.addChild(searchVc)
            self.view.addSubview(searchView)
            searchView.translatesAutoresizingMaskIntoConstraints = false
            searchView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
            searchView.heightAnchor.constraint(equalToConstant: 600).isActive = true
            searchView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
            searchView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        }
    }
    
    func setupPickerVC(){
        let pickerView = SPUIPickerCustomView()
        
        pickerView.setUser(user)
        pickerView.delegate = self
        
        self.view.addSubview(pickerView)
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        pickerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        pickerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        pickerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        pickerView.heightAnchor.constraint(equalToConstant: 300).isActive = true
    }
}

extension SPDChatroomViewController: SPUIDelegate {
    func onStickerSingleTapped(_ view: SPUIView, sticker: SPSticker) {
        print("onStickerSingleTapped")
        appendChat(.sticker(.me, sticker.stickerImg))
    }
    func onStickerDoubleTapped(_ view: SPUIView, sticker: SPSticker) {
        print("onStickerDoubleTapped")
        appendChat(.sticker(.me, sticker.stickerImg))
    }
    func pickerCustomViewSetup(_ view: SPUIView, pickerView: UIView) {
        // 1. Add view.
        self.view.addSubview(pickerView)

        // 2. Custom picker view.
        pickerView.alpha = 0.8

        // 3. Set constraint.
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        pickerView.topAnchor.constraint(equalTo: self.pickerViewPositionView.topAnchor).isActive = true
        pickerView.bottomAnchor.constraint(equalTo: self.pickerViewPositionView.bottomAnchor).isActive = true
        pickerView.leadingAnchor.constraint(equalTo: self.pickerViewPositionView.leadingAnchor).isActive = true
        pickerView.trailingAnchor.constraint(equalTo: self.pickerViewPositionView.trailingAnchor).isActive = true
    }
    
    func executePaymentForPackDownload(priceTier: SPPriceTier, packageId: Int, completion: @escaping (SPPriceTier, Int) -> Void) {
        /// 1. Proceed with payment process
        ///  ~
        /// 2. Return `priceTier & packageId` in the completion parameter
        completion(priceTier, packageId)
    }
    
    func executePaymentForPackDownload(packageId: Int, completion: @escaping (Int) -> Void) {
  
    }
    
    func spViewWillAppear(_ view: SPUIView){
        switch view {
        case is SPUIPickerInputView:
            print("⚡️Stipop: SPUIPickerInputView -> spViewWillAppear")
        case is SPUIPickerCustomView:
            print("⚡️Stipop: SPUIPickerCustomView -> spViewWillAppear")
        case is SPUISearchViewController:
            print("⚡️Stipop: SPUISearchViewController -> spViewWillAppear")
        case is SPUIStoreViewController:
            print("⚡️Stipop: SPUIStoreViewController -> spViewWillAppear")
        default:
            break
        }
    }
    func spViewDidAppear(_ view: SPUIView){
        switch view {
        case is SPUIPickerInputView:
            print("⚡️Stipop: SPUIPickerInputView -> spViewDidAppear")
        case is SPUIPickerCustomView:
            print("⚡️Stipop: SPUIPickerCustomView -> spViewDidAppear")
        case is SPUISearchViewController:
            print("⚡️Stipop: SPUISearchViewController -> spViewDidAppear")
        case is SPUIStoreViewController:
            print("⚡️Stipop: SPUIStoreViewController -> spViewDidAppear")
        default:
            break
        }
    }
    func spViewWillDisappear(_ view: SPUIView){
        switch view {
        case is SPUIPickerInputView:
            print("⚡️Stipop: SPUIPickerInputView -> spViewWillDisappear")
        case is SPUIPickerCustomView:
            print("⚡️Stipop: SPUIPickerCustomView -> spViewWillDisappear")
        case is SPUISearchViewController:
            print("⚡️Stipop: SPUISearchViewController -> spViewWillDisappear")
        case is SPUIStoreViewController:
            print("⚡️Stipop: SPUIStoreViewController -> spViewWillDisappear")
        default:
            break
        }
    }
    func spViewDidDisappear(_ view: SPUIView){
        switch view {
        case is SPUIPickerInputView:
            print("⚡️Stipop: SPUIPickerInputView -> spViewDidDisappear")
        case is SPUIPickerCustomView:
            print("⚡️Stipop: SPUIPickerCustomView -> spViewDidDisappear")
        case is SPUISearchViewController:
            print("⚡️Stipop: SPUISearchViewController -> spViewDidDisappear")
        case is SPUIStoreViewController:
            print("⚡️Stipop: SPUIStoreViewController -> spViewDidDisappear")
        default:
            break
        }
    }
}

extension SPDChatroomViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return chattings.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderCell") {
                return cell
            }
            break
        case 1:
            let cellModel = chattings[indexPath.row]
            switch cellModel {
            case .text(let sender, let content):
                if sender == .counter,
                   let cell = tableView.dequeueReusableCell(withIdentifier: "CounterTextCell") as? SPDCounterTextChatCell {
                    cell.contentLabel.text = content
                    return cell
                }
                if sender == .me,
                   let cell = tableView.dequeueReusableCell(withIdentifier: "MyTextCell") as? SPDMyTextChatCell {
                    cell.contentLabel.text = content
                    return cell
                }
            case .sticker(let sender, let urlString):
                if sender == .me,
                   let cell = tableView.dequeueReusableCell(withIdentifier: "MyStickerCell") as? SPDMyStickerChatCell {
                    cell.stickerView.setSticker(urlString)
                    return cell
                }
                if sender == .counter,
                   let cell = tableView.dequeueReusableCell(withIdentifier: "CounterStickerCell") as? SPDCounterStickerChatCell {
                    cell.stickerView.setSticker(urlString)
                    return cell
                }
            case .execution(_, let content, let onSelect):
                if let cell = tableView.dequeueReusableCell(withIdentifier: "CounterExecuteCell") as? SPDCounterExecuteChatCell {
                    cell.contentButton.setTitle(content, for: .normal)
                    cell.onSelectPerform = onSelect
                    return cell
                }
            }
        default:
            break
        }
        return UITableViewCell(style: .default, reuseIdentifier: "cell")
    }
}
// 키보드 숨기기
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
