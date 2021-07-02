//
//  ViewController.swift
//  ITicTecToe
//
//  Created by DCS on 02/07/21.
//  Copyright © 2021 DCS. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var xwin = 0
    var owin = 0
    
    private let mybg:UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "myGameBG")
        return img
    }()
    
  
    private let label1 : UILabel = {
        let lb = UILabel()
        lb.text = " X Player 1 "
        lb.font = UIFont.boldSystemFont(ofSize: 20)
        lb.textColor = .white
        return lb
    }()
    private let label2 : UILabel = {
        let lb = UILabel()
        lb.text = " O Player 2 "
        lb.font = UIFont.boldSystemFont(ofSize: 20)
        lb.textColor = .green
        return lb
    }()
    private let label3 : UILabel = {
        let lb = UILabel()
        lb.text = "0"
        lb.font = UIFont.boldSystemFont(ofSize: 30)
        lb.textColor = .white
        return lb
    }()
    private let label4 : UILabel = {
        let lb = UILabel()
        lb.text = "0"
        lb.font = UIFont.boldSystemFont(ofSize: 30)
        lb.textColor = .green
        return lb
    }()
    private let gamename : UILabel = {
        let lb = UILabel()
        lb.text = "Tic tac Toe"
        lb.font = UIFont.boldSystemFont(ofSize: 30)
        lb.textColor = .red
        return lb
    }()
    
    
    
    private var box = [2,2,2,2,
    2,2,2,2,
    2,2,2,2,
    2,2,2,2]
    
    private let winnerBox = [[0,1,2,3],[4,5,6,7],[8,9,10,11],[12,13,14,15],[0,4,8,12],[1,5,9,13],[2,6,10,14],[3,7,11,15],[0,5,10,15],[3,6,9,12]]
    
    private var flag = false
    
    private let myCollectionview:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = 	UIEdgeInsets(top: 200, left: 30, bottom: 10, right: 30)
        layout.itemSize = CGSize(width: 70, height: 70)
        let mycollection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        mycollection.backgroundColor = .red
        
        return mycollection
    }()
    
    
    override func viewDidLoad() {
        
        self.myCollectionview.backgroundView = mybg
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.addSubview(mybg)
        view.addSubview(myCollectionview)
        
        view.addSubview(gamename)
        view.addSubview(label1)
        view.addSubview(label2)
        view.addSubview(label3)
        view.addSubview(label4)
        
        setupMycollectionview()
        
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        mybg.frame = CGRect(x: 0, y: 0, width: view.width, height: view.height)
        myCollectionview.frame = view.bounds
        
        gamename.frame = CGRect(x: 120, y: 40, width: view.width, height: 40)
        label1.frame = CGRect(x: 30, y: 90, width: view.width, height: 40)
        label3.frame = CGRect(x: 60, y: 130, width: view.width, height: 40)
        label2.frame = CGRect(x: view.width - 140, y: 90, width: view.width, height: 40)
        label4.frame = CGRect(x: view.width - 100, y: 130, width: view.width, height: 40)
        
    }
    

}

extension ViewController : UICollectionViewDelegate,UICollectionViewDataSource {
   
    func setupMycollectionview()
    {
        myCollectionview.delegate = self
        myCollectionview.dataSource = self
        myCollectionview.register(gameboxCVC.self, forCellWithReuseIdentifier: "gameboxCVC")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return box.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "gameboxCVC", for: indexPath) as! gameboxCVC
        cell.setupCell(with: box[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if box[indexPath.row] != 0 && box[indexPath.row] != 1 {
            box.remove(at: indexPath.row)
            
            if flag {
                box.insert(0, at: indexPath.row)
            } else {
                box.insert(1, at: indexPath.row)
            }
            
            flag = !flag
            collectionView.reloadData()
            checkWinner()
        }
    }
    
    func checkWinner()
    {
        
        
        if !box.contains(2) {
            let alert = UIAlertController(title: "Game over!", message: "Draw. Try again", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: { [weak self] _ in
                self?.resetState()
            }))
            DispatchQueue.main.async {
                self.present(alert, animated: true, completion: nil)
            }
        }
        
        for i in winnerBox {
            if box[i[0]] ==  box[i[1]] && box[i[1]] ==  box[i[2]] && box[i[2]] ==  box[i[3]] && box[i[0]] != 2{
                 announceWinner(player: box[ i[0] ] == 0 ? "0" : "X")
                break
            }
        }
    }
    
    private func announceWinner(player: String) {
        if (player=="X"){
            xwin += 1
        }else {
            owin += 1
        }
        let alert = UIAlertController(title: "Game over!", message: "\(player) won", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: { [weak self] _ in
            self?.resetState()
        }))
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
        label3.text = String(xwin) + " pts"
        label4.text = String(owin) + " pts"
        
    }
    
    private func resetState() {
        box = [2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2]
        flag = false
        myCollectionview.reloadData()
    }
    
}

