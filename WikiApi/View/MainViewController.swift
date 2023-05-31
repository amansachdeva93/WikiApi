//
//  ViewController.swift
//  WikiApi
//
//  Created by Amanpreet Singh on 31/05/23.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var tableNotes: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var loaderStack: UIStackView!
    
    let viewModel = HomeViewModel()
    
    var list: [Page] = [] {
        didSet {
            self.tableNotes.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        // Do any additional setup after loading the view.
    }
}

@available(iOS 13.0, *)
extension MainViewController : UISearchBarDelegate
{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        loaderStack.isHidden = false
        viewModel.hitApi(searchedText: searchText) { [self] dictArray in
            let values = dictArray?.pages?.values
            if let _ = values
            {
                list.removeAll()
                list.append(contentsOf: values!)
                loaderStack.isHidden = true
            }
            loaderStack.isHidden = true
            print("getting: \(dictArray?.pages?.count)")
        }
    }
}


//Handling TableView Delegates.
extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 20))
        let label = UILabel()
        label.frame = CGRect.init(x: 5, y: 5, width: headerView.frame.width-10, height: headerView.frame.height + 10)
        label.text = "Results"
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = UIColor.label
        headerView.addSubview(label)
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! NoteCell
        cell.entity = list[indexPath.row]
        cell.configure()
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
}

