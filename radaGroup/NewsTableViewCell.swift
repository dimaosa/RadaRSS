//
//  PublicationTableViewCell.swift
//  radaRSSNews
//
//  Created by Osadchy Dima on 4/13/16.
//  Copyright © 2016 Osadchy Dima. All rights reserved.
//

class NewsTableViewCell: UITableViewCell {

    
    @IBOutlet weak var postImageView:UIImageView!
    @IBOutlet weak var authorImageView:UIImageView!
    @IBOutlet weak var postTitleLabel:UILabel!
    @IBOutlet weak var authorLabel:UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
