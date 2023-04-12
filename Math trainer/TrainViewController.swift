//
//  trainviewcontroller.swift
//  Math trainer
//
//  Created by Alexander on 6/4/2566 BE.
//


import UIKit

final class TrainViewController: UIViewController {
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var questionLabel: UILabel!
    
    // MARK: - Properties
    private var firstNumber = 0
    private var secondNumber = 0
    private var sign: String = ""
    private var count: Int = 0 {
        didSet{
            print("Count: \(count)")
        }
    }
    
    
    var type: MathTypes = .add {
        didSet {
            switch type {
            case .add:
                sign = "+"
            case .subtract:
                sign = "-"
            case .multiply:
                sign = "*"
            case .divide:
                sign = "/"
            }
        }
    }
    
    private var answer: Int {
        switch type {
        case .add:
            return firstNumber + secondNumber
        case .subtract:
            return firstNumber - secondNumber
        case .multiply:
            return firstNumber * secondNumber
        case .divide:
            return firstNumber / secondNumber
        }
    }
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        configureQuestion()
        configureButtons()
    }
    
    //MARK: - IBActions
    
    @IBAction func leftAction(_ sender: UIButton) {
        check(answer: sender.titleLabel?.text ?? "",
              for: sender)
    }
    @IBAction func rightButton(_ sender: UIButton) {
        check(answer: sender.titleLabel?.text ?? "",
              for: sender)
    }
    //MARK: - Methods
    private func configureButtons() {
        //reset color
        let buttonsArray =  [leftButton, rightButton]
        buttonsArray.forEach { button in
            button?.backgroundColor = .systemYellow }
        //Shadow
        buttonsArray.forEach { button in
            button?.layer.shadowColor = UIColor.gray.cgColor
            button?.layer.shadowOffset = CGSize(width: 3.0, height: 5.0)
            button?.layer.shadowOpacity = 0.6
            button?.layer.shadowRadius = 3
        }
        
        let isRightButton = Bool.random()
        var randomAnswer:Int
        repeat {
            randomAnswer = Int.random(in: (answer - 10)...(answer + 10))
        } while randomAnswer == answer
        rightButton.setTitle(isRightButton ? String(answer) : String(randomAnswer),
                        for: .normal)
        leftButton.setTitle(isRightButton ? String(randomAnswer) : String(answer), for: .normal)
        
    }
    private func configureQuestion() {
        
        
        firstNumber = Int.random(in: 1...99)
        secondNumber = Int.random(in: 1...99)
        
        if type == .divide {
            while firstNumber % secondNumber != 0 || firstNumber ==  secondNumber {
                secondNumber = Int.random(in: 1...firstNumber)
            }
        }
        
        var question: String = "\(firstNumber) \(sign) \(secondNumber) ="
        questionLabel.text = question
        
    }
    
    private func check(answer: String, for button: UIButton) {
        let isRightAnswer = Int(answer) == self.answer
        
        button.backgroundColor = isRightAnswer ? .green : .red
        
        if isRightAnswer {
            count += 1
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
                self?.configureQuestion()
                self?.configureButtons()
            }
        }
    }
}

