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
    @IBOutlet weak var stipopSearchButton: SPUIButton!
    @IBOutlet weak var messageField: UITextField!
    @IBOutlet weak var messageFieldBubble: UIView!
    @IBOutlet weak var messageFieldBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var messageSendButton: UIButton!
    @IBAction func messageSendButton(_ sender: Any) {
        if let text = messageField.text {
            appendChat(.text(.me, text))
            messageField.text = ""
            messageFieldDidChange(messageField)
        }
    }
    
    fileprivate var chattings: [SPDChatModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        configureTableView()
        configureMoreButton()
        configureMessageFields()
        configureStipopButton()
        
        appendChat(.text(.counter, "Hi, there!👋"))
        appendChat(.sticker(.counter, "https://img.stipop.io/2020/3/31/1585719674256_CookieArrow_size.gif"))
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { [weak self] in
            self?.appendChat(.text(.counter, "Welcome to Stipop SDK!\nPress the button below to get started."))
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) { [weak self] in
            self?.appendChat(.execution(.counter, "Try Sticker Picker View 😀", {
                self?.stipopPickerButton.sendActions(for: .touchUpInside)
                self?.appendChat(.text(.me, "Let me try Sticker Picker View 😀"))
            }))
            self?.appendChat(.execution(.counter, "Try Sticker Search View 🔍", {
                self?.stipopSearchButton.sendActions(for: .touchUpInside)
                self?.appendChat(.text(.me, "Let me try Sticker Search View 🔍"))
            }))
        }
    }
}

extension SPDChatroomViewController {
    func configureNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = #colorLiteral(red: 1, green: 0.4078431373, blue: 0.1058823529, alpha: 1)
        
        self.navigationController?.navigationBar.standardAppearance = appearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = appearance
        self.navigationController?.navigationBar.compactScrollEdgeAppearance = appearance
        self.navigationController?.navigationBar.compactScrollEdgeAppearance = appearance
        self.navigationController?.navigationBar.tintColor = .white
    }
    
    func configureTableView() {
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    func configureMoreButton() {
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
    func contactUs(action: UIAction) {
        guard let url = URL(string: "https://developers.stipop.io/contact-us") else { return }
        UIApplication.shared.open(url)
    }
    func goToGithub(action: UIAction? = nil) {
        guard let url = URL(string: "https://github.com/stipop-development/stipop-ios-sdk") else { return }
        UIApplication.shared.open(url)
    }
    
    func configureMessageFields() {
        messageFieldBubble.layer.cornerRadius = 20
        messageFieldBubble.layer.borderColor = #colorLiteral(red: 0.8274509804, green: 0.8274509804, blue: 0.8274509804, alpha: 1)
        messageFieldBubble.layer.borderWidth = 1
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
        let user = SPUser(userID: "some_user_id")
        
        stipopPickerButton.setUser(user, viewType: .picker)
        stipopPickerButton.delegate = self
        
        stipopSearchButton.setUser(user, viewType: .search)
        stipopSearchButton.delegate = self
    }
    
    func appendChat(_ chat: SPDChatModel) {
        chattings.append(chat)
        tableView.insertRows(at: [IndexPath(row: chattings.count-1, section: 1)], with: .right)
        scrollChatToBottom()
    }
    
    func scrollChatToBottom() {
        let indexPath = IndexPath(row: self.chattings.count-1, section: 1)
        self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
    }
}

extension SPDChatroomViewController: SPUIDelegate {
    func spViewDidSelectSticker(_ view: SPUIView, sticker: SPSticker) {
        appendChat(.sticker(.me, sticker.stickerImg))
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
