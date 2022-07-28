//
//  SearchMovieTableViewController.swift
//  SettingProject
//
//  Created by 최윤제 on 2022/07/20.
//

import UIKit

class SearchMovieTableViewController: UITableViewController {

    var movieList = MovieInfo()
    
    override func viewDidLoad() {
        super.viewDidLoad()

   
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieList.movie.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchMovieTableViewCell", for: indexPath) as! SearchMovieTableViewCell
        
        cell.titLabel.font = .boldSystemFont(ofSize: 15)
        cell.titLabel.text = movieList.movie[indexPath.row].title
        cell.releaseLabel.text = "2222.22.22"
        cell.overviewLabel.text = " 마블 코믹스의 캐릭터 아이언맨을 원작으로 하여 만들어진 슈퍼히어로 액션 영화이다. 마블 시네마틱 유니버스를 기반으로 한 첫 영화이자 마블 스튜디오에서 제작한 첫 번째 영화다. 감독은 존 패브로이다. 억만장자 사업가이자 천재 공학자인 토니 스타크가 아이언맨이라 불리는 무장 슈트를 만들어 평화를 지키기 위해 노력하는 이야기이다."
        cell.overviewLabel.numberOfLines = 0
        
        return cell
        
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height / 7
    }
    


    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let sb = UIStoryboard(name: "Trend", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "RecommandCollectionViewController") as! RecommandCollectionViewController
        
        vc.movieData = movieList.movie[indexPath.row]
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
