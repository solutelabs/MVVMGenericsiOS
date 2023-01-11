//  ProductSearchCell.swift

//  MVVMGenerics
//  Created by pramit D on 02/01/23.

import UIKit
import SDWebImage
class ProductSearchCell: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgHeader: UIImageView! {
        didSet {
            imgHeader.layer.cornerRadius = 8
            imgHeader.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var btnGet: UIButton! {
        didSet {
            btnGet.layer.cornerRadius = 16
            btnGet.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var imgResult: UIImageView! {
        didSet {
            imgHeader.layer.cornerRadius = 8
            imgHeader.layer.masksToBounds = true
        }
    }
    var appResult: Result! {
        didSet {
            lblTitle.text = appResult.trackName
            imgHeader.sd_setImage(with: URL(string: appResult.artworkUrl100))
            imgResult.sd_setImage(with: URL(string: appResult.screenshotUrls[0]))
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}
