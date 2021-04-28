//
//  DetailsViewController.swift
//  Currency Converter App
//
//  Created by Vũ Linh on 28/04/2021.
//

import UIKit

class DetailsViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var listData = [Currency]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "TableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: TableViewCell.identifier)
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
        getData()
    }
    
    private func getData() {
        guard let url = URL(string: "http://data.fixer.io/api/latest?access_key=4a990ae1cc0ef5a920e4c7e9eeb1123c") else {
            print("No data")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, resp, err in
            if err != nil {
                print(err?.localizedDescription)
                return
            }
            
            guard let data = data else {
                return
            }
            
            do {
                let jsonResponse = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! Dictionary<String, Any>
                
                DispatchQueue.main.async {
                    let array = Array(jsonResponse["rates"] as! [String: Any])
                    for (key, value) in array {
                        var entity = Currency(code: "")
                        entity.code = key
                        entity.value = value as! Double
                        self.listData.append(entity)
                        
                        self.tableView.reloadData()
                    }
                }
                
                print(self.listData.count)
                
            } catch {
                print("error")
            }
        }
        
        task.resume()
    }
}

extension DetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier, for: indexPath) as! TableViewCell
        cell.imageViewCell?.image = UIImage(named: listData[indexPath.row].image)
        cell.labelCell?.text = "\(listData[indexPath.row].value) : \(listData[indexPath.row].code)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
