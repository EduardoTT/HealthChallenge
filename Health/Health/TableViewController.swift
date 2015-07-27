//
//  ViewController.swift
//  SwiftSearch
//
//  Created by Shrikar Archak on 2/16/15.
//  Copyright (c) 2015 Shrikar Archak. All rights reserved.
//

import UIKit

class TableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate{
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var searchActive : Bool = false
    var data:[String] = [String]()
    var filtered:[String] = []
    var alimentoParaEnviar:Alimento?
    var alimentosExistentes:[String:Alimento] = [String:Alimento]()
    var quantidades:[String:Int] = [String:Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /* Setup delegates */
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        
        for a in DAO.sharedInstance.alimentosEscolhidos {
            alimentosExistentes[a.0] = a.1
        }
        
        for q in DAO.sharedInstance.quantidades {
            quantidades[q.0] = q.1
        }
        
        var alimentos:[String:Alimento] = DAO.sharedInstance.alimentosPorId
        for alimento in alimentos.values {
            if (!containsAlimento(alimento, dict: alimentosExistentes)) {
                data.append(alimento.valorNutricional.descricao)
            }
        }
        
    }
    
    func containsAlimento (alimento: Alimento, dict: [String:Alimento]) -> Bool {
        for temp in dict {
            if (alimento.id == temp.1.id) {
                return true
            }
        }
        return false
    }
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        searchActive = true;
    }
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        
        filtered = data.filter({ (text) -> Bool in
            let tmp: NSString = text
            let range = tmp.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch)
            return range.location != NSNotFound
        })
        if(filtered.count == 0){
            searchActive = false;
        } else {
            searchActive = true;
        }
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(searchActive) {
            return filtered.count
        }
        return data.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell") as! UITableViewCell;
        if(searchActive){
            cell.textLabel?.text = filtered[indexPath.row]
        } else {
            cell.textLabel?.text = data[indexPath.row];
        }
        
        return cell;
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue?, sender: AnyObject?) {
        if segue!.identifier == "paraFoto" {
            //let viewController:ViewController = segue!.destinationViewController as! ViewController
            alimentosExistentes[self.alimentoParaEnviar!.id] = self.alimentoParaEnviar!
            self.quantidades[alimentoParaEnviar!.id] = 100
            //viewController.alimentosEscolhidos = [String:Alimento]()
            DAO.sharedInstance.alimentosEscolhidos = [String:Alimento]()
            for alimento in alimentosExistentes {
//                viewController.alimentosEscolhidos[alimento.0] = alimento.1
//                viewController.quantidades[alimento.0] = self.quantidades[alimento.0]
                DAO.sharedInstance.alimentosEscolhidos[alimento.0] = alimento.1
                DAO.sharedInstance.quantidades[alimento.0] = self.quantidades[alimento.0]
            }
            println(DAO.sharedInstance.alimentosEscolhidos)
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        var cell = tableView.cellForRowAtIndexPath(indexPath)
        var text = cell?.textLabel?.text
        var alimento = DAO.sharedInstance.alimentosPorDescricao[text!]!
        self.alimentoParaEnviar = alimento
        self.performSegueWithIdentifier("paraFoto", sender: self)
       
    }
    

}