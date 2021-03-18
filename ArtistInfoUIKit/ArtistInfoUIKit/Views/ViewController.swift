//
//  ViewController.swift
//  ArtistInfoUIKit
//
//  Created by Ronald Joubert on 2/11/21.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var nameText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
//      FOR NOT SEGUEING
//    func goToTitleVC() {
//        guard let vc = TitleViewController.viewController(name: nameText.text ?? "") else { return }
//        self.present(vc, animated: true, completion: nil)
//    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as? TitleViewController
        vc?.nameData = nameText.text
    }
}

