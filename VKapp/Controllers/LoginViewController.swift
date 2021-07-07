//
//  LoginViewController.swift
//  VKapp
//
//  Created by Anna Delova on 7/6/21.
//

import UIKit
import WebKit

class LoginViewController: UIViewController {
    
    private var urlComponents: URLComponents = {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "oauth.vk.com"
        urlComponents.path = "/authorize"
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: "7861791"),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "scope", value: "336918"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "v", value: "5.131")
    ]
        return urlComponents
    }()
    lazy var request = URLRequest(url: urlComponents.url!)
    
    @IBAction func logoutSegue(for unwindSegue: UIStoryboardSegue) {
        Session.instance.token = ""
        Session.instance.userId = 0
        
        let dataStore = WKWebsiteDataStore.default()
        dataStore.fetchDataRecords(ofTypes: WKWebsiteDataStore.allWebsiteDataTypes()) { (records) in
            for record in records {
                if record.displayName.contains("vk") {
                    dataStore.removeData(ofTypes: WKWebsiteDataStore.allWebsiteDataTypes(), for: [record], completionHandler: { [weak self] in
                        self?.webView.load(self!.request)
                    })
                }
            }
        }
        webView.load(request)
    }
    
    @IBOutlet weak var webView: WKWebView! {
    didSet {
            webView.navigationDelegate = self
        }
    }
  override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.navigationDelegate = self
        webView.load(request)
    }
    

}
extension LoginViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        
        guard let url = navigationResponse.response.url,
            url.path == "/blank.html",
            let fragment = url.fragment else { decisionHandler(.allow); return }

        let params = fragment
            .components(separatedBy: "&")
            .map { $0.components(separatedBy: "=") }
            .reduce([String: String]()) { result, param in
                var dict = result
                let key = param[0]
                let value = param[1]
                dict[key] = value
                return dict
        }

        print(params)

        guard let token = params["access_token"],
            let userIdString = params["user_id"],
            let _ = Int(userIdString) else {
                decisionHandler(.allow)
                return
        }

        Session.instance.token = token
        Session.instance.userId = Int(userIdString)!


        performSegue(withIdentifier: K.Segue.login, sender: nil)
        
        decisionHandler(.cancel)
    }

}
