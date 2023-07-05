import UIKit

class KeyboardViewController: UIInputViewController {
    @IBOutlet var nextKeyboardButton: UIButton!
    @IBOutlet var numberBtn: [UIButton]!
    @IBOutlet var shuffleNum: [UIButton]!

//    @IBOutlet var SwipeBtn: UIButton!
    @IBOutlet var firstView: UIView!
    @IBOutlet var Label: UILabel!
    @IBOutlet var myView: UIView!
    @IBOutlet var secondView: UIView!
    
    
    @IBOutlet var forwardImageView: UIImageView!
    let config: KeyboardConfig = KeyboardConfig()
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
       
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "NumericKeyBoardView", bundle: nil)
        let objects = nib.instantiate(withOwner: self, options: nil)
        
        view = objects[0] as? UIView
        
        let keybackGround = KeyboardConfig.keyBackgroundColor
        let keyforeGround = KeyboardConfig.keyTextColor
        myView.backgroundColor = KeyboardConfig.keyTextColor
//        self.view.backgroundColor = backgroundColor
        for button in numberBtn {
            button.backgroundColor = keybackGround
            button.setTitleColor(KeyboardConfig.keyTextColor, for: .normal)
        }
        
        shuffleNumberKeypad()
        initializeSubviews()
        
        self.nextKeyboardButton = UIButton(type: .system)
        self.nextKeyboardButton.setTitle(NSLocalizedString("Next Keyboard", comment: "Title for 'Next Keyboard' button"), for: [])
        self.nextKeyboardButton.sizeToFit()
        self.nextKeyboardButton.translatesAutoresizingMaskIntoConstraints = false
        self.nextKeyboardButton.addTarget(self, action: #selector(handleInputModeList(from:with:)), for: .allTouchEvents)
        self.view.addSubview(self.nextKeyboardButton)
        
        self.nextKeyboardButton.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.nextKeyboardButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
		
		let left : UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(performSwipeAction(sender:)))
		//[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(PerformAction:)];
		left.direction = .left
		forwardImageView.addGestureRecognizer(left)
		
		let right : UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(performSwipeAction(sender:)));
		right.direction = .right
		forwardImageView.addGestureRecognizer(right)

    }
	
	@objc func performSwipeAction(sender : UISwipeGestureRecognizer)  {
		if(sender.direction == .right) {
			print("RIGHT GESTURE")
			// Perform your code here
		}
		
		if(sender.direction == .left) {
			print("LEFT GESTURE")
			// Perform your code here
		}
		swipeAnimation(range: 100)
	}

    
    func shuffleNumberKeypad() {
        var numbers = Array(0...9).shuffled()
        
        for (index, button) in shuffleNum.enumerated() {
            let number = numbers[index]
            button.setTitle(String(number), for: .normal)
        }
    }
    
    @IBAction func moveAction(_ sender: Any) {
        swipeAnimation(range: 100)
    }
    
    func swipeAnimation(range: CGFloat) {
        UIView.animateKeyframes(withDuration: 4, delay: 0, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0.25, relativeDuration: 0.25, animations: {
                self.forwardImageView.alpha = 0.8
            })
            UIView.addKeyframe(withRelativeStartTime: 0.50, relativeDuration: 0.25, animations: {
				self.forwardImageView.center.x = self.view.bounds.width - range            })
        })
        Label.text = "Success"
    }
    func initializeSubviews() {
        let xibFileName = "NumericKeyBoardView"
        let view = Bundle.main.loadNibNamed(xibFileName, owner: self, options: nil)?[0] as! UIView
        self.view.addSubview(firstView)
        firstView.frame = self.view.bounds
        shuffleNumberKeypad()
//        SwipeBtn.layer.cornerRadius = 15
//        SwipeBtn.layer.masksToBounds = true
        firstView.layer.cornerRadius = 15
        firstView.layer.masksToBounds = true
        
        let firstColor: UIColor = UIColor(named: "#27252F") ?? .systemTeal
        let lastColor: UIColor = UIColor(named: "#27252F") ?? .systemTeal
        
        let gradient = CAGradientLayer()
        gradient.startPoint = CGPoint(x: 0.5, y: 0.5)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradient.colors = [firstColor.cgColor, lastColor.cgColor]
        gradient.frame = firstView.bounds  // Set the frame of the gradient layer
        
        // Add the gradient layer as a sublayer to the desired view
        firstView.layer.insertSublayer(gradient, at: 0)
    }

    override func viewWillLayoutSubviews() {
        self.nextKeyboardButton.isHidden = !self.needsInputModeSwitchKey
        super.viewWillLayoutSubviews()
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        let tappedButton = sender.titleLabel?.text
        (textDocumentProxy as UIKeyInput).insertText("\(tappedButton ?? "")")
    }
    
    @IBAction func backSpaceTapped(_ sender: Any) {
        if let backSpace = textDocumentProxy as? UIKeyInput {
            backSpace.deleteBackward()
        }
    }
    
    override func textDidChange(_ textInput: UITextInput?) {
        
        var textColor: UIColor
        let proxy = self.textDocumentProxy
        if proxy.keyboardAppearance == UIKeyboardAppearance.dark {
            textColor = UIColor.white
        } else {
            textColor = UIColor.black
        }
    }
    
    // New method to initialize subviews
   
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        initializeSubviews()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initializeSubviews()
    }
   
}
