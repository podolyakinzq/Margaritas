//
//  DetailsViewController.swift
//  Margaritas
//
//  Created by Серёня on 11.08.2022.
//

import UIKit

class DetailsViewController: UIViewController {
    var margarita: Margarita!
    
    @IBOutlet weak var margaritaImage: UIImageView!
    @IBOutlet weak var margaritaIngredients: UILabel!
    @IBOutlet weak var margaritaInstructions: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
  
    private func setupUI() {
        Task {
            do {
                let data = try await NetworkManager.shared.fetchImage(from: margarita.strDrinkThumb ?? "")
                margaritaImage.image = UIImage(data: data)
            }
        }
        margaritaIngredients.text = margarita.composition
        margaritaInstructions.text = margarita.strInstructions
    }
}
