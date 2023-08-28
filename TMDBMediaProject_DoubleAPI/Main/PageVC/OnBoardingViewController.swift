//
//  OnBoardingViewController.swift
//  TMDBMediaProject_DoubleAPI
//
//  Created by 염성필 on 2023/08/25.
//

import UIKit
import SnapKit

class FirstVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
    }
}

class SecondVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
    }
}

class ThirdVC: UIViewController {
    
    let button = {
        let button = UIButton()
        button.setTitle("다음버튼", for: .normal)
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .orange
        view.addSubview(button)
        button.addTarget(self, action: #selector(nextBtnClicked), for: .touchUpInside)
        button.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(100)
        }
    }
    
    @objc func nextBtnClicked() {
        print("다음 버튼이 눌렸음")
      //  let sb = UIStoryboard(name: "Main", bundle: nil)
        
//        guard let vc = sb.instantiateViewController(withIdentifier: MainViewController.identifier) as? MainViewController else { return }
       let vc = MainViewController()
       let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: false)
       // navigationController?.pushViewController(vc, animated: true)
        
       // present(vc, animated: true)
        
    }
    
    
}

class OnBoardingViewController: UIPageViewController {
    
    var list: [UIViewController] = []
    override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .purple
        list = [FirstVC(), SecondVC(), ThirdVC()]
        
        delegate = self
        dataSource = self
        // 처음 시작 화면을 어떤걸로 보여줄 것이냐
        guard let first = list.first else { return }
        setViewControllers([first], direction: .forward, animated: true)
    }
}
extension OnBoardingViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    // 이전 요소가 있다면
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        // 특정 요소를 기준으로 앞에서부터 몇 번째에 있는지
        guard let currentVC = list.firstIndex(of: viewController) else { return nil }
        
        let previousVC = currentVC - 1
        
        return previousVC < 0 ? nil : list[previousVC]
    }
    
    // 다음 요소가 있다면
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        // 특정 요소를 기준으로 앞에서부터 몇 번째에 있는지
        guard let currentVC = list.firstIndex(of: viewController) else { return nil }
        
        let afterVC = currentVC + 1
        
        return afterVC >= list.count ? nil : list[afterVC]
    }
    
    // 페이징 컨트롤 갯수를 몇개 보여줄 것인가?
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return list.count
    }
    
    
    // 페이징이 될때마다 페이지 컨트롤의 상태를 변화시켜줌
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        guard let first = viewControllers?.first,
              let index = list.firstIndex(of: first) else { return 0 }
        return index
    }
    
}
