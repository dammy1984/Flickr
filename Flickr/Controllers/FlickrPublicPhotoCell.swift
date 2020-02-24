//
//  FlickrPublicPhotoCell.swift
//  Flickr
//
//  Created by Basavaraj KM on 23/02/20.
//  Copyright © 2020 Basavaraj KM. All rights reserved.
//

import UIKit
import SDWebImage

class FlickrPublicPhotoCell: UITableViewCell {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var authorLabel: UILabel!
    @IBOutlet var photoView: UIImageView!
    @IBOutlet weak var imageLoader: UIActivityIndicatorView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        photoView.layer.borderWidth = 1.0
        photoView.layer.cornerRadius = 5.0
        photoView.layer.borderColor = UIColor(red: 0.61, green: 0.61, blue: 0.61, alpha: 1.0).cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        photoView.image = nil
        imageLoader.stopAnimating()
    }

    var cellModel: PhotoViewModel? {
        didSet {
            bindViewModel()
        }
    }

    func bindViewModel() {
        if let photoURL = cellModel?.link {
            imageLoader.startAnimating()
            photoView.sd_setImage(with: URL(string: photoURL), placeholderImage: nil) { (image: UIImage?, _: Error?, _: SDImageCacheType, _: URL?) in
                self.photoView.image = image
                self.imageLoader.stopAnimating()
            }
        } else {
            photoView.image = nil
            imageLoader.stopAnimating()
        }

        titleLabel?.text = cellModel?.title
        authorLabel?.text = cellModel?.author
    }
}
