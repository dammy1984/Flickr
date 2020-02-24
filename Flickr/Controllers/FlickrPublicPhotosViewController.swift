//
//  FlickrPublicPhotosViewController.swift
//  Flickr
//
//  Created by Basavaraj KM on 23/02/20.
//  Copyright © 2020 Basavaraj KM. All rights reserved.
//

import UIKit
import MBProgressHUD

class FlickrPublicPhotosViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var tableViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var tagSearch: UISearchBar!
    
    let viewModel = FlickrPublicPhotosViewModel()
    private var ascending = true

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.tableFooterView = UIView()
        load(forTag: "")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupObservers()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeObservers()
    }
    
    private func load(forTag inTag: String) {
        viewModel.clearData()
        tableView.reloadData()
        tableView.contentOffset = .zero
        
        let progress = MBProgressHUD.showAdded(to: self.view, animated: true)
        progress.label.text = "Loading…"
        viewModel.retrievePublicPhotos(forTags: inTag) { [unowned self] (error: Error?) in
            MBProgressHUD.hide(for: self.view, animated: true)
            self.tableView.reloadData()
            if let errorObj = error {
                Util.showAlert("", errorObj.localizedDescription)
            }
        }
    }
    
    private func removeObservers() {
        let notificationCenter = NotificationCenter.default
        
        notificationCenter.removeObserver(self)
    }

    private func setupObservers() {
        let notificationCenter = NotificationCenter.default
                
        notificationCenter.addObserver(self,
                                               selector: #selector(FlickrPublicPhotosViewController.keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        notificationCenter.addObserver(self,
                                               selector: #selector(FlickrPublicPhotosViewController.keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }

    // MARK: - Actions
    @IBAction func toggleSort(_ sender: Any) {
        ascending = !ascending
        viewModel.sortData(isAscending: ascending)
        tableView.reloadData()
    }
    
    @objc func keyboardWillShow(sender: NSNotification) {
        if let keyboardSize = (sender.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue,
            tableViewBottomConstraint.constant == 0 {
            tableViewBottomConstraint.constant = keyboardSize.height
        }
    }
    
    @objc func keyboardWillHide(sender: NSNotification) {
        if tableViewBottomConstraint.constant > 0 {
            tableViewBottomConstraint.constant = 0.0
        }
    }
}

extension FlickrPublicPhotosViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
        if let searchText = searchBar.text {
            load(forTag: searchText)
        }
    }
}

extension FlickrPublicPhotosViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FlickrPublicPhotoCell") as? FlickrPublicPhotoCell
        guard let publicPhotoCell = cell else {
            return UITableViewCell()
        }

        publicPhotoCell.cellModel = viewModel.publicPhoto(at: indexPath.row)
        return publicPhotoCell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.publicPhotosCount
    }

}
