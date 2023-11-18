//
//  NetworkClient.swift
//  HeadHunter
//
//  Created by Роман Козловский on 16.11.2023.
//

import Foundation

enum Method: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

enum RequestType {
    case vacancyList
    case detailedVacancy
}

struct ApiPath {
    static let vacancies = "vacancies"
    static let keyword = "suggests/vacancy_search_keyword"
}

// MARK: - NetworkClientProtocol

protocol NetworkClientProtocol: AnyObject {
    func request<T: Decodable>(
        path: String,
        page: Int?,
        method: Method,
        requestType: RequestType,
        completion: @escaping(Result<T?, Error>) -> Void)
    
    func createDataTask<T: Decodable>(
        urlRequest: URLRequest,
        completion: @escaping(Result<T?, Error>) -> Void)
}


// MARK: - NetworkClientProtocol

class NetworkClient: NetworkClientProtocol {
    
    // MARK: - Private Properties
    
    private lazy var urlSession: URLSession = {
        let session = URLSession(configuration: .default)
        return session
    }()
    
    private var dataTask: URLSessionDataTask? = nil
    
    // MARK: - Public Methods
    
    func request<T: Decodable>(
        path: String,
        page: Int?,
        method: Method = .get,
        requestType: RequestType,
        completion: @escaping(Result<T?, Error>) -> Void) {
            
            let baseStringUrl = NetworkConfig.baseUrl + ApiPath.vacancies //todo вынести apiPath в параметры
            
            guard var urlComponents = URLComponents(string: baseStringUrl) else {
                completion(.failure(CustomError(message: "Wrong URL!")))
                return
            }
            
            switch requestType {
                
            case .vacancyList:
                var queryItems: [URLQueryItem] = urlComponents.queryItems ?? []
                let vacancyQueryItems: [URLQueryItem] = [
                    URLQueryItem(name: "text", value: path),
                    URLQueryItem(name: "page", value: String(page ?? 0)),
                    URLQueryItem(name: "per_page", value: "20")
                ]
                vacancyQueryItems.forEach { queryItem in
                    queryItems.append(queryItem)
                }
                urlComponents.queryItems = queryItems
                var urlRequest = URLRequest(url: (urlComponents.url)!)
                urlRequest.httpMethod = method.rawValue
                createDataTask(urlRequest: urlRequest, completion: completion)
                
            case .detailedVacancy:
                let stringUrl = baseStringUrl + "/" + path
                guard let url = URL(string: stringUrl) else {
                    completion(.failure(CustomError(message: "Wrong URL!")))
                    return
                }
                var urlRequest = URLRequest(url: url)
                urlRequest.httpMethod = method.rawValue
                createDataTask(urlRequest: urlRequest, completion: completion)
            }
        }
    
    func createDataTask<T: Decodable>(
        urlRequest: URLRequest,
        completion: @escaping(Result<T?, Error>) -> Void)  {
            dataTask = urlSession.dataTask(with: urlRequest, completionHandler: { data, response, error in
                if let data = data {
                    let content = JsonDecodeHelper.shared.decode(data: data, type: T.self)
                    completion(.success(content))
                } else {
                    completion(.failure(CustomError(message: "No Data!")))
                }
            })
            dataTask?.resume()
        }
}


