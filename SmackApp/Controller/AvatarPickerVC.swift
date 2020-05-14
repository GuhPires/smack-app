//
//  AvatarPickerVC.swift
//  SmackApp
//
//  Created by Gustavo Mac Mini on 13/05/20.
//  Copyright © 2020 DEVX. All rights reserved.
//

import UIKit

class AvatarPickerVC: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: - Actions
    @IBAction func onBackTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onSegmentControlChanged(_ sender: Any) {
    }
    
}

// MARK: - Collection View methods
extension AvatarPickerVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 28
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "avatarCell", for: indexPath) as? AvatarCell {
            return cell
        }
        return UICollectionViewCell()
    }
    
    
}
