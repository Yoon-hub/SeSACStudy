//
//  WebViewController.swift
//  WebVeiwPorject
//
//  Created by 최윤제 on 2022/07/28.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    
    @IBOutlet weak var userSearchBar: UISearchBar!
    @IBOutlet weak var userWebView: WKWebView!
    
    var url: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userSearchBar.text = url
        userSearchBar.delegate = self
        openWebPage(url: url)
        navigationController?.navigationBar.topItem?.title = ""
  
    }
    
    func openWebPage(url: String){
        let url = URL(string: url)!
        let request = URLRequest(url: url)
        userWebView.load(request)
        
    }
    
    @IBAction func xButtonClicked(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func backButtonClicked(_ sender: UIBarButtonItem) {
        if userWebView.canGoBack{
            userWebView.goBack()
        }
        
    }
    @IBAction func reloadButtonClicked(_ sender: UIBarButtonItem) {
        userWebView.reload()
    }
    
    @IBAction func goforwadButtonClicked(_ sender: UIBarButtonItem) {
        if userWebView.canGoForward{
            userWebView.goForward()
        }
    }
}


extension WebViewController: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        openWebPage(url: searchBar.text!)
    }
}
