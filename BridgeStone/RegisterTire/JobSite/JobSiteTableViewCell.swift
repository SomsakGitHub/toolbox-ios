//
//  JobSiteTableViewCell.swift
//  BridgeStone
//
//  Created by somsak on 16/5/2563 BE.
//  Copyright © 2563 Ifrasoft. All rights reserved.
//

import UIKit

class JobSiteTableViewCell: UITableViewCell {
    
    @IBOutlet weak var JobSiteLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func initView(jobsites: Jobsites){
        self.JobSiteLabel.text = jobsites.jobsiteName
    }

}
