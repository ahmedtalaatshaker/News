//
//  SelectionView.swift
//  News
//
//  Created by Ahmed Talaat on 04/11/2022.
//

import UIKit

protocol SelectionViewProtocol {
    func select(_ selectionView: SelectionView)
}

enum SelectionType{
    case single
    case multi
}

@IBDesignable
class SelectionView: UIView {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var button: UIButton!
    
    var isSelected = false
    var selectionType: SelectionType = .single
    var delegate: SelectionViewProtocol?
    
    func setData(text: String, isSelected: Bool, selectionType: SelectionType) {
        setSelected(select: isSelected, selectionType: selectionType)
        title.text = text
    }
    
    func setSelected(select: Bool, selectionType: SelectionType) {
        self.isSelected = select
        self.selectionType = selectionType
        switch selectionType {
        case .single:
            button.setImage(select ? UIImage(named: "checkbox") : UIImage(named: "unchecked"), for: .normal)
        case .multi:
            button.setImage(select ? UIImage(named: "radio-buttons_selected") : UIImage(named: "radio-button_unselected"), for: .normal)
        }
    }
    
    @IBAction func selectTabbed(_ sender: Any) {
        delegate?.select(self)
    }
    
    required init(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)!
        
        self.commonInit()
    }
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        self.commonInit()
    }
    
    func commonInit() {
        
        guard let view = Bundle(for: type(of: self)).loadNibNamed("SelectionView", owner: self, options: nil)?.first as? UIView else {
            return
        }
        
        frame = view.bounds
        
        self.addSubview(view)
        setupUI()
    }
    
    func setupUI() {
        self.layer.borderWidth = 1
        self.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
        self.layer.cornerRadius = 15
        
    }
}
