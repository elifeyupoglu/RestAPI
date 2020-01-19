//
//  AlbumsViewController.swift
//  RestAPI
//
//  Created by Elif on 6.01.2020.
//  Copyright © 2020 Elif. All rights reserved.
//

import UIKit
import SwiftyJSON

class AlbumsViewController: UIViewController {
    
    // MARK: - UI Elements
    @IBOutlet weak var albumsTableView: UITableView!
    
    // MARK: - Properties
    var tableViewData = [[AlbumsData]]()
    var selectedAlbumId = 0
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        getAlbumsJSONData()
    }
    
    // MARK: - Functions
    private func getAlbumsJSONData(){
        let url: String = "http://jsonplaceholder.typicode.com/albums"
        let urlRequest = URL(string: url)
        URLSession.shared.dataTask(with: urlRequest!, completionHandler: {
            (data, response, error) in
            if(error != nil){
                print(error.debugDescription)
            }else {
                do{
                    let json = try JSONDecoder().decode([AlbumsData].self,from: data!)
                    for index in 1...10 {
                        let userId = json.filter({$0.userId == index})
                        self.tableViewData.append(userId)
                    }
                    DispatchQueue.main.async {
                        self.albumsTableView.reloadData()
                    }
                }catch let error as NSError {
                    print(error)
                }
            }
        }).resume()
    }
}

// MARK: - UITableviewDataSource & UITableViewDelegate
extension AlbumsViewController: UITableViewDelegate, UITableViewDataSource {
    // Kaç adet hücre çizileceğini belirten fonksiyon
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return tableViewData[section].count
    }
    
    // Çizilecek hücrelerin yüksekliğini belirten fonksiyon
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return 70
    }
    
    // Hücrelerin çizilmesinden sorumlu fonksiyon
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AlbumCell", for: indexPath) as? AlbumsTableViewCell else {
            return UITableViewCell()
        }
        
        let albumData = tableViewData[indexPath.section][indexPath.row]
        cell.titleLabel.text = "Title: \(albumData.title)"
        cell.titleLabel.numberOfLines = 0
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = tableViewData[indexPath.row]
        tableView.deselectRow(at: indexPath, animated: true)
        let albumData = tableViewData[indexPath.section][indexPath.row]
        selectedAlbumId = albumData.id
        performSegue(withIdentifier: "toShowDetail", sender: item)
    }
    
    // Kaç adet  'section' olduğunu belirten fonksiyon
    func numberOfSections(in tableView: UITableView) -> Int {
        return tableViewData.count
    }
    
    // Her 'section' için bir başlık belirten fonksiyon
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "User Id : \(tableViewData[section][0].userId)"
    }
    
    // Her 'section' yüksekliğini belirten fonksiyon
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toShowDetail" {
            if let destinationVC = segue.destination as? DetailAlbumViewController{
                destinationVC.selectedAlbumId = self.selectedAlbumId
            }
        }
    }
}



