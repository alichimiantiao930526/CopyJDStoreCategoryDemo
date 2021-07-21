//
//  BJSearchBar.swift
//  DAOSearchBarDemo
//
//  Created by home on 2017/11/23.
//  Copyright © 2017年 likeabossapp. All rights reserved.
//

import UIKit

let BJSearchImageInset: CGFloat = 11.0
let BJSearchBarLeftInset: CGFloat = 33.0
let BJSearchBarRightInset: CGFloat = 30.0
let BJSearchBarImageSize: CGFloat = 22.0
protocol BJSearchBarDelegate{
    func searchBarTextDidChange(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String)
    func searchBarReturn(_ textField: UITextField)
}
class BJSearchBar: UIView , UITextFieldDelegate{
    
    let searchField:UITextField
    let searchImage:UIImageView
    let searchImageViewOnContainerView:UIView
    let searchImageCircle:UIImageView
    let searchImageCrossLeft:UIImageView
    let searchImageCrossRight:UIImageView
    //delegate的值是暴露出来给其他类使用的 所以有没有赋值不一定 用？号 并且要用Var因为要给它赋值
    var delegate:BJSearchBarDelegate?

    override init(frame: CGRect) {
   
        //搜索框
        searchField = UITextField(frame:CGRect(x:BJSearchBarLeftInset, y:3.0, width:frame.size.width-BJSearchBarRightInset, height:frame.size.height-6.0))
        searchField.placeholder = "请输入商品名"
        searchField.keyboardType = .webSearch
        searchField.backgroundColor = UIColor.white
       
        
        //左边的搜索图标
        searchImage=UIImageView(frame:CGRect(x:BJSearchImageInset, y:(frame.size.height-BJSearchBarImageSize)/2, width:BJSearchBarImageSize, height:BJSearchBarImageSize))
        searchImage.image = UIImage(named: "NavBarIconSearch")
        
        //右边的X号按钮
       searchImageViewOnContainerView = UIView()
       searchImageViewOnContainerView.frame = CGRect(x:frame.size.width-BJSearchBarRightInset, y: (frame.size.height-BJSearchBarImageSize)/2, width: BJSearchBarImageSize, height: BJSearchBarImageSize)
     
       searchImageCircle = UIImageView()
       searchImageCircle.frame = CGRect(x: 2.0, y: 2.0, width: 18.0, height: 18.0)
       searchImageCircle.image = UIImage(named: "NavBarIconSearchCircle")
       searchImageCircle.alpha = 0
        
       searchImageCrossLeft = UIImageView()
       searchImageCrossLeft.frame = CGRect(x: 7.0, y: 7.0, width: 8.0, height: 8.0)
       searchImageCrossLeft.image = UIImage(named: "NavBarIconSearchBar")
       searchImageCrossLeft.alpha = 0
      
       searchImageCrossRight = UIImageView()
       searchImageCrossRight.frame = CGRect(x: 7.0, y: 7.0, width: 8.0, height: 8.0)
       searchImageCrossRight.image = UIImage(named: "NavBarIconSearchBar2")
       searchImageCrossRight.alpha = 0
      
        
        super.init(frame: frame)
        
        
        searchField.delegate = self
        
        //整个View
        self.backgroundColor = UIColor.white
        self.layer.cornerRadius = self.bounds.height / 2
        self.layer.masksToBounds = true
        
        self.addSubview(searchImage)
        self.addSubview(searchField)
        self.addSubview(searchImageViewOnContainerView)
       
        searchImageViewOnContainerView.addSubview(searchImageCircle)
        searchImageViewOnContainerView.addSubview(searchImageCrossLeft)
        searchImageViewOnContainerView.addSubview(searchImageCrossRight)
        
        
        let gestureRecognizer = UITapGestureRecognizer()
        gestureRecognizer.addTarget(self, action: #selector(dismissCross(_:)))
        searchImageViewOnContainerView.addGestureRecognizer(gestureRecognizer)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        //判断有没有指针 判断空 传过去BJSearchBar得到 应该跟上面参数一样整个传过去 这样可以得到它的改变
        if (self.delegate != nil){
            self.delegate?.searchBarTextDidChange(textField, shouldChangeCharactersIn: range, replacementString: string)
        }
        searchImageCircle.alpha = 1
        searchImageCrossLeft.alpha = 1
        searchImageCrossRight.alpha = 1
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) ->Bool{
        if (self.delegate != nil){
            self.delegate?.searchBarReturn(textField)
        }
        return true
    }
    
    @objc func dismissCross(_ gesture:UITapGestureRecognizer){
        searchField.text = ""
        searchImageCircle.alpha = 0
        searchImageCrossLeft.alpha = 0
        searchImageCrossRight.alpha = 0
    }
}
