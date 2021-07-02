//
//  gameboxCVC.swift
//  ITicTecToe
//
//  Created by DCS on 02/07/21.
//  Copyright © 2021 DCS. All rights reserved.
//

import UIKit

class gameboxCVC: UICollectionViewCell {
    
    private let mycell:UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.clipsToBounds = true
        return img
    }()
    
    func setupCell(with status:Int)
    {
        contentView.layer.borderWidth = 1
        contentView.addSubview(mycell)
        mycell.frame = CGRect(x: 0, y: 0, width: 70, height: 70)
       let name = status == 0 ? "oicon" : status == 1 ? "xicon" : ""
        mycell.image = UIImage(named: name)
    }
    
}
