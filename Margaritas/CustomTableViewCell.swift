//
//  CustomTableViewCell.swift
//  Margaritas
//
//  Created by Серёня on 12.08.2022.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var ritaImage: UIImageView!
    @IBOutlet weak var ritaName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        ritaName.text = ""
    }
    
    func setupCell(with rita: Margarita) {
        Task {
            do {
                let data = try await NetworkManager.shared.fetchImage(from: rita.strDrinkThumb ?? "" )
                ritaImage.image = UIImage(data: data)
            }
        }
        ritaName.text = rita.strDrink
    }

}
