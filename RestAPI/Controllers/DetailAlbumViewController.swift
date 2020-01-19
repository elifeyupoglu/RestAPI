//
//  DetailAlbumViewController.swift
//  RestAPI
//
//  Created by Elif on 7.01.2020.
//  Copyright © 2020 Elif. All rights reserved.
//

import UIKit
import SwiftyJSON

class DetailAlbumViewController: UIViewController {
    
    // MARK: - UI Elements
    @IBOutlet weak var albumCollectionView: UICollectionView!
    
    // MARK: - Properties
    var collectionViewFlowLayout: UICollectionViewFlowLayout!
    var collectedData = [PhotosData]()
    var selectedAlbumId = 0
    var vSpinner : UIView?
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        getAlbumDetailJSONData()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.removeSpinner()
            self.filterArray()
        }
    }
    
    // MARK: - Functions
    private func configureCollectionView() {
        albumCollectionView.delegate = self
        albumCollectionView.dataSource = self
    }
    
    private func getAlbumDetailJSONData(){
        let url: String = "http://jsonplaceholder.typicode.com/photos"
        let urlRequest = URL(string: url)
        self.showSpinner(onView: self.view)
        URLSession.shared.dataTask(with: urlRequest!) {
            (data, response, error) in
            if(error != nil){
                print(error.debugDescription)
            }else {
                do{
                    let json = try JSONDecoder().decode([PhotosData].self,from: data!)
                    self.collectedData = json
                    DispatchQueue.main.async {
                        self.albumCollectionView.reloadData()
                    }
                }catch let error as NSError {
                    print(error)
                }
            }
        }.resume()
    }
    
    private func filterArray() {
        var filtredData: [PhotosData] = []
        for i in 0 ... 4999 {
            if(self.collectedData[i].albumId == self.selectedAlbumId) {
                filtredData.append(self.collectedData[i])
            }
        }
        self.collectedData = filtredData
        configureCollectionView()
    }
    
    private func showSpinner(onView : UIView) {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let activityIndicator = UIActivityIndicatorView.init(style: .large)
        activityIndicator.startAnimating()
        activityIndicator.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(activityIndicator)
            onView.addSubview(spinnerView)
        }
        vSpinner = spinnerView
    }
    
    private func removeSpinner() {
        DispatchQueue.main.async {
            self.vSpinner?.removeFromSuperview()
            self.vSpinner = nil
        }
    }
}

// MARK: - UICollectionViewDataSource & UICollectionViewDelegate
extension DetailAlbumViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.collectedData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? AlbumCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let user = self.collectedData[indexPath.row]
        if let url = NSURL(string: user.url) {
            if let data = NSData(contentsOf: url as URL) {
                cell.imageView?.image = UIImage(data: data as Data)
            }
        }
        cell.titleLabel?.text = user.title
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension  DetailAlbumViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        // Toplam ekran genişliği
        let availableWidth = view.frame.width
        
        // Hücrelerin ekranın sağ ve sol taraflarına olan uzaklığı
        let sectionInset: CGFloat = 20.0
        
        // Hücrelerin arasındaki mesafe
        let cellSpacing: CGFloat = 15.0
        
        // Bir hücrenin hesaplanmış genişliği
        let cellWidth = (availableWidth - sectionInset * 2 - cellSpacing) / 2
        
        // Bir hücrenin hesaplanmış boyutu
        let cellSize = CGSize(width: cellWidth.rounded(.down), height: 225)
        
        return cellSize
    }
}
