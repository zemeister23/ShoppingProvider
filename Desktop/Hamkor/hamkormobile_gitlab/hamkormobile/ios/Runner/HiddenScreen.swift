//
//  HiddenScreen.swift
//  Runner
//
//  Created by zemeister on 7/29/22.
//

import UIKit

class HiddenScreen: UITableViewController{
    init(){
        super.init(style: .grouped)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder){
        fatalError("Init coder has not been implemented")
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        let labelHeight = view.bounds.height * 0.66
        (privacyLabel.frame, _) = view.bounds.divided(atDistance: labelHeight, from: .minYEdge)
    }
    
    private lazy var privacyLabel: UILabel = {
        let label = UILabel()
        
        
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        label.adjustsFontForContentSizeCategory = true
        label.adjustsFontSizeToFitWidth = true
        
        label.textAlignment = .center
        label.textColor = .black
        
        label.numberOfLines = 0
        label.text = ""
        
        
        self.view.addSubview(label)
                
        return label
        
    }()
}

