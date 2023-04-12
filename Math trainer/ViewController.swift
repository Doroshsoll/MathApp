//
//  ViewController.swift
//  Math trainer
//
//  Created by Alexander on 3/4/2566 BE.
//

import UIKit

enum MathTypes: Int {
    case add, subtract, multiply, divide
}

class ViewController: UIViewController {
    //MARK: - IBOtlets
    @IBOutlet var buttonsCollection: [UIButton]!
    
    //MARK: - Properties
    var selectedType: MathTypes = .add
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureButtons()
    }

    // MARK: - Actions
    @IBAction func buttonsAction(_ sender: UIButton) {
        selectedType = MathTypes(rawValue: sender.tag) ?? .add
        performSegue(withIdentifier: "goToNext", sender: sender)
    }
    
    @IBAction func unwindAction(unwindfSegue: UIStoryboardSegue) { }
    
    // MARK: - Methods
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? TrainViewController{
            viewController.type = selectedType
        }
    }
    
    private func configureButtons() {
        // Add Shadow
        buttonsCollection.forEach { button in
            button.layer.shadowColor = UIColor.gray.cgColor
            button.layer.shadowOffset = CGSize(width: 3.0, height: 5.0)
            button.layer.shadowOpacity = 0.6
            button.layer.shadowRadius = 3
            
        }
    }
}

