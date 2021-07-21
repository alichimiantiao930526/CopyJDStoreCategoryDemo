//
//  ViewController.swift
//  HalfCircleSearchBar
//
//  Created by home on 2017/11/23.
//  Copyright © 2017年 home. All rights reserved.
//

import UIKit
//下一步 要把代理方法拿过来 因为输入的是什么要知道 所以要在textField的代理方法里面写一个代理方法传过来 要写代理方法
let BJWidth = UIScreen.main.bounds.size.width
let classifyArray = ["0","1","2","3","4","5","6","7","8","9"]
class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,BJSearchBarDelegate{
    @IBOutlet weak var searchBarFrameView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    

    func CreateSearchBar() {
        
        //并不能及时拿到自动坐标 自动坐标估计得到最后才能计算出来
        //加上section
        let search = BJSearchBar.init(frame: searchBarFrameView.frame)
        search.delegate = self
        collectionView.delegate = self
        self.view.addSubview(search)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        super.view.layoutSubviews()
        self.view.backgroundColor = UIColor.lightGray
        CreateSearchBar()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "TableViewCell")
        tableView.tableFooterView = UIView.init(frame: CGRect.zero)
        collectionView.register(UINib(nibName:"BJCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CollectionViewCell")
        //collectionView的头head
        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind:UICollectionElementKindSectionHeader , withReuseIdentifier: "CollectionHead")
        collectionView.backgroundColor = UIColor.lightGray
        collectionView.contentInset = UIEdgeInsetsMake(100,0,0,10)

        //3个item不能紧挨的原因是默认的cell间距是10
        flowLayout.itemSize =  CGSize(width:(collectionView.frame.size.width-10)/3, height:(collectionView.frame.size.width-30)/3+20)
        flowLayout.headerReferenceSize = CGSize(width:collectionView.frame.width,height:40)
        collectionView.collectionViewLayout = flowLayout
        let imageArray = ["banner","banner","banner"]
        let cycleScrollView = SDCycleScrollView.init(frame:CGRect(x:0, y:-100,width:collectionView.frame.size.width-10, height:100), imageNamesGroup:imageArray)
        collectionView.addSubview(cycleScrollView!)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return classifyArray.count;
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier:"TableViewCell", for: indexPath)
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        cell.textLabel?.text = classifyArray[indexPath.row]
        cell.textLabel?.textAlignment = .center
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell:UITableViewCell = tableView.cellForRow(at: indexPath)!
        cell.backgroundColor = UIColor.lightGray
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell:UITableViewCell = tableView.cellForRow(at: indexPath)!
        cell.backgroundColor = UIColor.white
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.separatorInset = UIEdgeInsets.zero
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 5;
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9;
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier:"CollectionViewCell", for:indexPath)
        return cell 
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let headView:UICollectionReusableView=collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "CollectionHead", for: indexPath)
            let label:UILabel = UILabel.init(frame:CGRect(x:10,y:0,width:200,height:40))
            label.text = "专场推荐"
            headView.addSubview(label)
        
        return headView
    }
    
    
    //代理方法
    func searchBarTextDidChange(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) {
        
    }
    func searchBarReturn(_ textField: UITextField) {
        //这里的！号
        print(textField.text!)
    }

   
    
}
