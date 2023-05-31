//
//  NoteCell.swift
//  WikiApi
//
//  Created by Amanpreet Singh on 31/05/23.
//

import UIKit

class NoteCell: UITableViewCell {
    
    @IBOutlet weak var imgLogo: UIImageView!
    @IBOutlet weak var subTitle: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    
    var entity: Page?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func actionCheck(_ sender: Any) {
      //  entity?.status = !(entity?.status ?? false)
      //  tickTapped!(entity ?? NoteEntity())
    }
    
    func configure() {
        subTitle.text = entity?.extract
        lblTitle.text = entity?.title?.capitalized
        imgLogo.isHidden = false
      
        func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
            URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
        }
        
        if let urlString = entity?.thumbnail?.source
        {
            getData(from: URL(string: urlString)!) { data, res, error in
                guard let data = data, error == nil else { return }
                
                DispatchQueue.main.async() { [self] in
                    imgLogo.image = UIImage(data: data)
                        }
                
            }
        }
        else
        {
            imgLogo.isHidden = true
        }
       
        imgLogo.layer.borderWidth = 1
        imgLogo.layer.masksToBounds = false
        imgLogo.layer.borderColor = UIColor.black.cgColor
        imgLogo.layer.cornerRadius = 25
        imgLogo.clipsToBounds = true
        
        
    }
  
}
