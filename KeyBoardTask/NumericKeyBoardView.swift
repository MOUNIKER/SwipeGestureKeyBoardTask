//
//  NumericKeyBoardView.swift
//  KeyBoardTask
//
//  Created by Sindhu Bachu on 27/06/23.
//

import UIKit

protocol KeyboardDelegate: AnyObject{
    func numWasTapped(character: String)
    func backspaceTapped()
    func dismissTapped() -> Bool
}

class NumericKeyBoardView: UIView {

    @IBOutlet var numberBtn: [UIButton]!
    @IBOutlet var SwipeBtn: UIButton!
    @IBOutlet var firstView: UIView!
    @IBOutlet var Label: UILabel!
    @IBOutlet var myView: UIView!

    @IBOutlet var secondview: UIView!
    weak var delegate: KeyboardDelegate?
    var shuffledNumbers: [String] = []
       required init?(coder aDecoder: NSCoder) {
           super.init(coder: aDecoder)
           initializeSubviews()
           shuffleNumberKeypad()
    
    }

    @IBAction func moveAction(_ sender: Any) {
        swipeAnimation(range: 48)
    }
    func swipeAnimation(range: CGFloat)
    {
    UIView.animateKeyframes(withDuration: 4, delay: 0, animations: {
        
        UIView.addKeyframe(withRelativeStartTime: 0.25, relativeDuration: 0.25, animations: {
            self.SwipeBtn.alpha = 0.5
        })
        UIView.addKeyframe(withRelativeStartTime: 0.50, relativeDuration: 0.25, animations: {
            self.SwipeBtn.center.x = self.firstView.bounds.width - range
        })
    })
        Label.text = "Success"

}
   func initializeSubviews() {
        let xibFileName = "NumericKeyBoardView"
        let view = Bundle.main.loadNibNamed(xibFileName, owner: self, options: nil)?[0] as! UIView
        self.addSubview(view)
        view.frame = self.bounds

//            randomizeColors()
        let labelWidth: CGFloat = 200
            let labelHeight: CGFloat = 50

      Label.frame = CGRect(x: 72, y: 15, width: 361, height: 59)
          Label.layer.cornerRadius = 15
          Label.layer.masksToBounds = true
      }
    override init(frame: CGRect) {
           super.init(frame: frame)
           initializeSubviews()
           shuffleNumberKeypad()
           SwipeBtn.layer.cornerRadius = 15
           SwipeBtn.layer.masksToBounds = true
           firstView.layer.cornerRadius = 15
           firstView.layer.masksToBounds = true
        
        randomizeColors()
        let firstColor: UIColor = UIColor(named: "#27252F") ?? .systemTeal
        let lastColor: UIColor = UIColor(named: "#27252F") ?? .systemTeal

        let gradient = CAGradientLayer()
        gradient.startPoint = CGPoint(x: 0.5, y: 0.5)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradient.colors = [firstColor.cgColor, lastColor.cgColor]

       }
    
    func updateButtonTitles(numbers: [String]) {
        guard numbers.count == subviews.count else {
                return
            }
            for (index, button) in subviews.enumerated() {
                if let numberButton = button as? UIButton {
                    numberButton.setTitle(numbers[index], for: .normal)
                }
            }
        }
    func shuffleNumberKeypad() {
            var numbers = Array(0...9).shuffled()
                
                for (index, button) in numberBtn.enumerated() {
                    let number = numbers[index]
                    button.setTitle(String(number), for: .normal)
                }
            }
    func randomizeColors() {
                let backgroundColor = generateRandomColor()
    //            let buttonBackgroundColor = generateRandomColor()
                let foregroundColor = generateRandomColor()

                let randomColor = generateRandomColor()
                myView.backgroundColor = randomColor

                self.backgroundColor = backgroundColor

                for button in numberBtn {
                    button.backgroundColor = backgroundColor
                    button.setTitleColor(foregroundColor, for: .normal)
                }
            }

    func generateRandomColor() -> UIColor {
              let red = CGFloat.random(in: 0...1)
              let green = CGFloat.random(in: 0...1)
              let blue = CGFloat.random(in: 0...1)

              return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
          }
    @IBAction func buttonTapped(sender: UIButton){
        self.delegate?.numWasTapped(character: sender.titleLabel!.text!)
    }
    
    @IBAction func backSpaceTapped(sender: UIButton){
        self.delegate?.backspaceTapped()
    }

    }


