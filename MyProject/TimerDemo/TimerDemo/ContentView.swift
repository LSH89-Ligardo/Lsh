import UIKit
import SnapKit
import Then

protocol LocationSelectedProtocol: NSObject {
    func dataSend(data: [TimeWeather])
}

enum Section: CaseIterable {
    case main
}

final class MainViewController: UIViewController {
    
    // MARK: - Properties
    var delegate: LocationSelectedProtocol?
    var filteredLocationData = [WeatherLocation]()
    var dataSource: UITableViewDiffableDataSource<Section, WeatherLocation>!
    
    // MARK: - UI Components
    private let searchController = UISearchController()
    private let mainContentView = UIView()
    private let mainTableView = UITableView(frame: .zero, style: .insetGrouped).then {
        $0.backgroundColor = .black
    }
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupUI()
        self.setTableViewConfig()
        self.performQuery(with: nil)
    }
}

// MARK: - Extensions
extension MainViewController {
    // UI 세팅
    private func setupUI() {
        
        setupLayout()
        setNavigationBar()
        setSearchBar()
    }
    
    // 레이아웃 세팅
    private func setupLayout() {
        self.view.addSubViews(mainTableView)
        
        mainTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.barTintColor = .black
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationItem.title = "Weather"
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "moreIcon"),
                                                            style: .plain,
                                                            target: nil,
                                                            action: nil)
        navigationItem.rightBarButtonItem?.tintColor = .white
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    private func setSearchBar() {
        navigationItem.searchController = searchController
        navigationItem.searchController?.searchBar.placeholder = "Search for a city or airport"
        navigationItem.searchController?.searchResultsUpdater = self
        
        let textFieldInsideSearchBar = navigationItem.searchController?.searchBar.value(forKey: "searchField") as? UITextField
        textFieldInsideSearchBar?.textColor = .white
    }
    
    private func setTableViewConfig() {
        self.mainTableView.register(MainLocationTableViewCell.self,
                                    forCellReuseIdentifier: MainLocationTableViewCell.identifier)
        self.mainTableView.delegate = self
        
        // self.mainTableView.dataSource = self
        self.dataSource = UITableViewDiffableDataSource<Section, WeatherLocation>(tableView: mainTableView) { (tableView, indexPath, location) -> UITableViewCell? in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MainLocationTableViewCell.identifier, for: indexPath) as? MainLocationTableViewCell else { return UITableViewCell() }
            
            cell.bindData(data: location, row: indexPath.row)
            cell.selectionStyle = .none
            
            return cell
        }
        
        self.mainTableView.dataSource = dataSource
    }
    
    func performQuery(with filter: String?) {
        self.filteredLocationData = dummyLocationData.filter { return $0.location.lowercased().contains(filter ?? "".lowercased()) }
        
        // self.mainTableView.reloadData()
        var snapshot = NSDiffableDataSourceSnapshot<Section, WeatherLocation>()
        snapshot.appendSections([.main])
        if self.isFilterting {
            snapshot.appendItems(filteredLocationData)
        } else {
            snapshot.appendItems(dummyLocationData)
        }
        self.dataSource.apply(snapshot, animatingDifferences: true)
    }
}

extension MainViewController: UISearchResultsUpdating {
    var isFilterting: Bool {
        let searchController = self.navigationItem.searchController
        let isActive = searchController?.isActive ?? false
        let isSearchBarHasText = searchController?.searchBar.text?.isEmpty == false
        
        return isActive && isSearchBarHasText
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        performQuery(with: text)
    }
}

// MARK: - TableView Delegate
extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 133
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailPageVC = DetailPageViewController()
        
        for index in 0 ..< dummyLocationData.count {
            let detailVC = DetailViewController()
            detailVC.indexNumber = index
            detailPageVC.viewControllersArray.append(detailVC)
        }
        
        let firstVC = detailPageVC.viewControllersArray[indexPath.row]
        detailPageVC.pageVC.setViewControllers([firstVC], direction: .forward, animated: true)
        
        self.navigationController?.pushViewController(detailPageVC, animated: true)
    }
}
