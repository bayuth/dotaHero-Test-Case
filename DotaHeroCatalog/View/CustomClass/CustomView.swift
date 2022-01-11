//
//  CustomView.swift
//  DotaHeroCatalog
//
//  Created by Bayu Triharyanto on 10/01/22.
//

import UIKit

class CustomView: UIView {

    @IBOutlet var parentView: UIView!
    @IBOutlet weak var attrImg: UIImageView!
    @IBOutlet weak var attrLabel: UILabel!
    
    let nibName = "CustomView"
    var contentView:UIView?
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    func commonInit() {
        guard let view = loadViewFromNib() else { return }
        view.frame = self.bounds
        self.addSubview(view)
        contentView = view
    }
    
    func loadViewFromNib() -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }

}
